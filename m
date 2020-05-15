Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D41D504C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEOOXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 10:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEOOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:23:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93CFE2076A;
        Fri, 15 May 2020 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589552628;
        bh=6R+Xi8P/zfipyLDRIy6hLIDaQEC20tzTQym4EoyHh/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHPePjMW3i3M8c2Y7Y8wblCRASGmrd7emqY5oB6OTqfHa+x9HjbsYbmP18QuTU55U
         lytDX2mAO29R4A/zkkjbVpfw0kHxPsK/A4luRg75pxABOWveLsrpQ2Ud2LXAg+UQE9
         GxUo8fkv4ptPyMQo/HWwlD/hZeKoIib0xQm5Nkaw=
Date:   Fri, 15 May 2020 16:23:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ipack: tpci200: fix error return code in
 tpci200_register()
Message-ID: <20200515142345.GA2409034@kroah.com>
References: <20200507094237.13599-1-weiyongjun1@huawei.com>
 <eaaa54dbe413bf3f13f08c267e6c31c497afb509.camel@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaaa54dbe413bf3f13f08c267e6c31c497afb509.camel@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:34:06PM +0200, Samuel Iglesias Gonsálvez wrote:
> Hello Wei,
> 
> Thanks for the patch!
> 
> Patch is,
> 
> Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> 
> Greg, Would you mind picking this patch series through your char-misc
> tree?

Sure, will do.

greg k-h
