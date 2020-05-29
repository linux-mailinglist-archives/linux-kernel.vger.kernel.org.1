Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D31E77BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgE2IEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 04:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgE2IDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:03:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 074D0206F1;
        Fri, 29 May 2020 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590739423;
        bh=douQtXqt1bLulssMQ62YOJgjfN2ETkl+BkTbiEledHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoETBXB74eUUyusE3Qg9jdnipa71lglt+UrGVdjOD+g9sQBmC1izHTfodIUWZCA+s
         yHNdgsaOhgwGVr1Mhq6OVIXLVmK9m8oZt2J4t2h9eOBoh5EfhJzVec1+3lFVXB19W4
         AktEhrLLBd338zvzOze03aOO2Dw63pbQJKj9wb8k=
Date:   Fri, 29 May 2020 10:03:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.8
Message-ID: <20200529080341.GB599635@kroah.com>
References: <CGME20200529030043epcas1p2a41f6271b91e086a2e730a488ce53015@epcas1p2.samsung.com>
 <a7f317f3-5499-d1d5-cabd-b53d7e8d9977@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f317f3-5499-d1d5-cabd-b53d7e8d9977@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:11:03PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.8. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:
> 
>   Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.8

As my char-misc-next branch is currently at 5.7-rc5, why did you need to
make this against -rc7?

Mind if I just rebase your patches against my tree instead of pulling
the whole thing up to -rc7, or is there some dependancy there that you
needed to do this?

thanks,

greg k-h
