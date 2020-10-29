Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7329E8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgJ2K33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgJ2K33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:29:29 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E6F20782;
        Thu, 29 Oct 2020 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603967368;
        bh=eDNouMwfAkiromxxzvTEEY8/dwiXpUUMsSqp2SyTwYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRFnAUykbUa9YQUUF+cV72CvZM04bkeA5y2+5gY+ApFOFbxmgULMnhi46FL2Bhju/
         0/KTyBigOe8biQUv6iAigLUSdBiTEejzY7HO8O0cV/9D7GxH+jEGrzqzrfoFQhlTY4
         KKPfCZR7Kqc9Dp3R+E4mXPUbczInzJ0qHmZZwAA0=
Date:   Thu, 29 Oct 2020 11:30:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: Fix spelling in comments
Message-ID: <20201029103018.GB3763875@kroah.com>
References: <20201029100759.21668-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100759.21668-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:37:59PM +0530, Bhaskar Chowdhury wrote:
> Fixed two spelling in two different comments.
> 
> s/defalut/default/p
> 
> This is in linux-next.

No need for this line, it doesn't make any sense here, right?

