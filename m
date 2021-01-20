Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32D82FD7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbhATSDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389273AbhATRyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:54:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71997223DB;
        Wed, 20 Jan 2021 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611165201;
        bh=UGhENdaeBDK+RDGsyYCMGEuBLqO3g9ARjTKYvxzAmes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXBI+GM8fW2O+0r0Po/pmZAuXLQPY439yhHb5+TKWvkFaZUHZGDYuXYQAhteaaBbY
         g3BDYDPWzZ9YA19AlSJkQycCxni3F2jffoQaQm3QRQX3xFdT+7XOkL8+g7Z6gn8X5L
         Az912/k9hVWmOjgs4RhpJcEIVxRelIWEFwaO8Mf4=
Date:   Wed, 20 Jan 2021 18:53:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PING: [PATCH v5 0/2] misc: pvpanic: introduce capability & event
 attribute
Message-ID: <YAhuD04p4daZd/1W@kroah.com>
References: <20210110115358.79100-1-pizhenwei@bytedance.com>
 <cee80030-dab1-fe79-f14c-24e45532d814@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee80030-dab1-fe79-f14c-24e45532d814@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:42:57AM +0800, zhenwei pi wrote:
> Hi, Greg
> 
> What's the next step I should take?

I need some reviews by the people who will be doing the qemu portion of
this, or someone else, please.

thanks,

greg k-h
