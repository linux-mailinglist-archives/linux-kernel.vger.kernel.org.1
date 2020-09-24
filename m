Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF58277752
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgIXQ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIXQ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:59:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A3C0613CE;
        Thu, 24 Sep 2020 09:59:58 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB141750;
        Thu, 24 Sep 2020 16:59:54 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:59:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v4 0/4] docs: fb: Removed framebuffer scrollback related
 documentations
Message-ID: <20200924105952.1448fb46@lwn.net>
In-Reply-To: <cover.1600333774.git.unixbhaskar@gmail.com>
References: <cover.1600333774.git.unixbhaskar@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 15:56:11 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> In this patch series, documentation get in sync with the code removal
> of scrollback,by this commit 50145474f6ef ("fbcon: remove soft scrollback code"),
> by eliminating the information related to it.
> 
> 
> Changes since V3:
> 
> Remove the wrong commit hash and messages from all the 4 patches i.e 
> Commit 973c096f6a85(vgacon: remove software scrollback support)
> from the patches as suggested by Willy and Greg.
> 
> Patch 1: Remove the documentation related to framebuffer scrollback from the file
>    fbcon.rst
> 
> Patch 2: Remove the documentation  boot option for scrollback from the file matroxfb.rst
> 
> Patch 3: Remove the documentation scrollback option from sstfb.rst file.
> 
> Patch 4: Remove the documentation scrollback option from vesafb.rst file. 

Set applied, thanks.

jon
