Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500C01B5AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgDWLkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 07:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgDWLkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:40:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716EC2084D;
        Thu, 23 Apr 2020 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587642034;
        bh=v+cZbNEq+8xq9TdljfKBzmW0OSxSI3Wv8ELxe4MyXrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBJms3bpeviFauiUcUCQiOq4YvvYk8OFWsy6Mp3B3HOj2vHhfIUOdLNK6VE7XTw/v
         0ouOwtoiVcQZBwXoRq0gVUDPF5lCTPzp00Kx+NssOTIojVr14VSLr5B6qEeEIXo/Co
         PVQZ5gxk+pxMcaBUiQjn3KKxoZiOVne9eWvObe4I=
Date:   Thu, 23 Apr 2020 13:40:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: vt6656: Check the return value of
 vnt_control_out_* calls
Message-ID: <20200423114032.GA3838948@kroah.com>
References: <20200419104821.6127-1-oscar.carter@gmx.com>
 <20200419104821.6127-2-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419104821.6127-2-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 12:48:20PM +0200, Oscar Carter wrote:
> Check the return value of vnt_control_out_* function calls. When
> necessary modify the function prototype to be able to return the new
> checked error code.
> 
> It's safe to modify all the function prototypes without fix the call
> because the only change is the return value from void to int. If before
> the call didn't check the return value, now neither.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>

This patch, and the 2/2 patch did not apply to my tree.  Can you please
rebase and resend?

thanks,

greg k-h
