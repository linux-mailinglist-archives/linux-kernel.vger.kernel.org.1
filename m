Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC82632F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgIIQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbgIIP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:57:19 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC776C0617BB;
        Wed,  9 Sep 2020 06:39:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjkQ2FV7z9sVM; Wed,  9 Sep 2020 23:37:34 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     oprofile-list@lists.sf.net, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Colin King <colin.king@canonical.com>,
        Robert Richter <rric@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200804174316.402425-1-colin.king@canonical.com>
References: <20200804174316.402425-1-colin.king@canonical.com>
Subject: Re: [PATCH] powerpc/oprofile: fix spelling mistake "contex" -> "context"
Message-Id: <159965824316.811679.2643424244803475085.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:37:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 18:43:16 +0100, Colin King wrote:
> There is a spelling mistake in a pr_debug message. Fix it.

Applied to powerpc/next.

[1/1] powerpc/oprofile: fix spelling mistake "contex" -> "context"
      https://git.kernel.org/powerpc/c/346427e668163e85cbbe14e4d9a2ddd49df1536c

cheers
