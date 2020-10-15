Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A928F1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgJOMCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgJOMCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:02:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6552120691;
        Thu, 15 Oct 2020 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602763341;
        bh=L4zRarBb0KLaucGa55Y4+DQfPRjFJ0GvajLvlotOR9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zTvJrAWNnkj1kwfW10uQZoYlR21+q7Lb9V55cZsTuKKMiWcB9LwL4vQEJPklGM+D3
         ss39Huj+nR+1CCPGxhImnNuBQpziPHFRzfq9A77bYkIStfoWz4OTFIil1C1nd9Aorj
         HvgEp1nk4J7I09iHGvu9CCNGibUocgff6X8/MVAo=
Date:   Thu, 15 Oct 2020 14:02:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Hans-Christian Egtvedt (hegtvedt)" <hegtvedt@cisco.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption
 handling in hci_encrypt_cfm
Message-ID: <20201015120254.GA3958402@kroah.com>
References: <20201015074333.445510-1-hegtvedt@cisco.com>
 <20201015095750.GA3935178@kroah.com>
 <0804be81-ebbf-8132-a619-c0c740a71f51@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0804be81-ebbf-8132-a619-c0c740a71f51@cisco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:18:39AM +0000, Hans-Christian Egtvedt (hegtvedt) wrote:
> On 15/10/2020 11:57, Greg KH wrote:
> > On Thu, Oct 15, 2020 at 09:43:32AM +0200, Hans-Christian Noren Egtvedt wrote:
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> This makes hci_encrypt_cfm calls hci_connect_cfm in case the connection
> >> state is BT_CONFIG so callers don't have to check the state.
> >>
> >> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >> (cherry picked from commit 3ca44c16b0dcc764b641ee4ac226909f5c421aa3)
> > 
> > This is only in 5.8, what about all the other stable kernels?
> > 
> >> (cherry picked from commit 0a60996c7fa7010ea00d9b62fb6996d908a01ead)
> > 
> > Where is this commit from?  I don't see it in Linus's tree.
> 
> Ops, my bad, I have a Linux 4.9 branch, which also includes the Android
> 4.9 kernel changes from Google. And since I noticed the patches in my
> (merged from Android latest) linux-4.9.y branch, I thought the patches
> were applied through all stable releases 4.9 and up.

I just looked at the google common android trees, and do not see this
commit in the android-4.9-q branch.  What branch are you seeing it in?

> >> ---
> >> AFAICT, fixing CVE 2020-10135 Bluetooth impersonation attacks have been
> >> left out for the 4.4 stable kernel. I cherry picked what I assume are
> >> the appropriate two patches missing from the 4.9 stable kernel. Please
> >> add them to upcoming 4.4 stable releases.
> > 
> > Why are you merging 2 commits together?  Please provide backports for
> > all stable kernels, if you want to see this in the 4.4.y tree.  We can
> > not have someone move from an older tree to a newer one and have a
> > regression.
> 
> Agreed, I have managed to trick myself into thinking the 4.4.y branch
> was left out, but I assume these patches are required for all LTS branches.

They are, but if you have copies of them, please feel free to share
them.

thanks,

greg k-h
