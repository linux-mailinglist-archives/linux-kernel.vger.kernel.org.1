Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30211E582B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgE1HF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 03:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:05:56 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E4C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:05:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeCbw-00Gis8-SI; Thu, 28 May 2020 07:05:52 +0000
Date:   Thu, 28 May 2020 08:05:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200528070552.GJ23230@ZenIV.linux.org.uk>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528070255.GA790247@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:02:55AM +0200, Ingo Molnar wrote:

> Looks good to me.
> 
> I'm wondering, shouldn't we also zero-initialize the dump data to 
> begin with? See the patch below (untested).

Note that this hides the bug from KASAN, though ;-)  And the bug
is not just infoleak - not all components are "all zeroes" in the
init state.
