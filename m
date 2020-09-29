Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76C27C6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgI2Lu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbgI2Lty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:49:54 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D091020702;
        Tue, 29 Sep 2020 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601380193;
        bh=IcH/OkK6c6PgRmS2MU+VFYNCA6U6LxmqTLkCNxc9sss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBwMP6VkVMk8SU+Kr95qjPWHLGmfUTA4KcHFMIxAFBf23LsHrAVzrkBkyIPOUIKTu
         0MjWCeoNfExNFnmUeZkVQs0IOVRaPGTQRv01XmpGBzMnjdCBe6MXl+J1LIKnhBQWKe
         UsWH01iufmTzubfCf93jYgNbqT5W9g549Hh8/Mt4=
Date:   Tue, 29 Sep 2020 13:05:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.10
Message-ID: <20200929110509.GA1160194@kroah.com>
References: <CGME20200929091112epcas1p47da3938ff71bcacaa2691f158a471289@epcas1p4.samsung.com>
 <64750b49-15be-7d51-7ae9-cb1dd4092fa4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64750b49-15be-7d51-7ae9-cb1dd4092fa4@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 06:24:23PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.10. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:
> 
>   Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.10

I get the following error from my scripts (which match what linux-next
will also tell you):

Commit: 00a29c98369d ("extcon: ptn5150: Do not print error during probe if nothing is attached")
	Fixes tag: Fixes: af71b7e384cd ("extcon: ptn5150: Check current USB mode when probing")
	Has these problem(s):
	        - Target SHA1 does not exist

Please fix up.

thanks,

greg k-h
