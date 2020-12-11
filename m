Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A72D7234
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392832AbgLKItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392462AbgLKIsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:48:24 -0500
Date:   Fri, 11 Dec 2020 09:48:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607676463;
        bh=xOCT7y4SwVssF613mOM0wzoGAp4GHbR6vud7FlNin/o=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8d0u1RBofu3LgQ4J5qdGneaEFHm8NQT7cM+nx+x2MHVE9Amrxmx6UMaWe6w7zebW
         S6MjQ3YgX18+tPu5hwoqTuLQl9gZMoBlRemsVLFP2uiEedYaiVPAk0htxWOkOxFCx/
         AxohsO3q7WcpoxKrQp0HiiioFWDXMnJ7GtyzJkvk=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.11
Message-ID: <X9Myatv1BiWgZ8Uk@kroah.com>
References: <CGME20201211081239epcas1p4809436b16fc6d6595ea8ce4e2343aecb@epcas1p4.samsung.com>
 <ad016689-0ffd-e398-1ce0-a3c20dd030ee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad016689-0ffd-e398-1ce0-a3c20dd030ee@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 05:27:24PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.11. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:
> 
>   Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.11

Pulled and pushed out, thanks.

greg k-h
