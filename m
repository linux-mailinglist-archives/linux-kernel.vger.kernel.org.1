Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A702CE755
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 06:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgLDFTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 00:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLDFTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 00:19:35 -0500
Date:   Thu, 3 Dec 2020 21:18:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607059135;
        bh=NTtFOG1GQx90cr9hCi4Q6/ZGEbwo1wz4YjAws8quq+Y=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeJEBuIP38Tw8Wdzo5/eCldxIhwTUc8sNMSvPvgbFt2S20Y9dxy9kLd62M+gHvkxo
         O8HVGaq6anDcfW50A8aEF4n/ZpmXLzLoUc4Zzs7+lKhKhxMng0nuuL9adZeytp/OSB
         LyEAOjTfLbu3fhCdYgGoje7zBqi/3efX5GzhWskoDMWAJVlMbb0qhM8VBslu194Sma
         4XmZXW8sf7Ysvsv2QL2KYcLZ1PynVMnTRL047LF4GgZFZMt/Wkszc3acv8bt1U89WP
         nPI79ftT1h9Au9Z6v+kyfAXWUKIEZfx99g53LYngTW0GWixkycvUpetG94nhsFCfTB
         A2njq7xqQhaGA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in
 decompression
Message-ID: <X8nGvfEeTDTLa6FL@sol.localdomain>
References: <20201204005847.654074-1-daeho43@gmail.com>
 <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain>
 <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
 <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
 <X8nAParf9GW9LaGV@sol.localdomain>
 <CACOAw_wOShYf23Y0txs6Fk_Qq9JGEjXGRb0MzMxrBxJpzCfLmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_wOShYf23Y0txs6Fk_Qq9JGEjXGRb0MzMxrBxJpzCfLmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 02:00:34PM +0900, Daeho Jeong wrote:
> I think I don't understand how verity works.
> Right after verity is enabled on a file, is the verity logic working
> for the whole file data area?
> Or it's just working for the data area which is updated after verity is enabled?
> 

It's for the whole file.

My point is just that if there is a bio that saw that verity isn't enabled yet
when it started and therefore STEP_VERITY didn't get set in the
bio_post_read_ctx (or the bio_post_read_ctx didn't get allocated due to one not
being needed), then the filesystem shouldn't change its mind and try to verify
the pages when the bio completes if verity happened to be enabled concurrently.
It's too late for that bio.

- Eric
