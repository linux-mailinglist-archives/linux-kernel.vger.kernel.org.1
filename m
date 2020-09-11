Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A797E265AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 09:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKHlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 03:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgIKHlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:41:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4185B214F1;
        Fri, 11 Sep 2020 07:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599810098;
        bh=iclbaUke67strvxO69V8rHGud4aAV6dPmHjYGaZ7l04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhF/aIM7T7UXsLu2H1gAIFBM53tA7pVnAARdLT7TteMOVJki98F4H9HJ7h1sJY957
         ia/7mY1obIjUPVw/7Dbn7TUqS41qAK2Yk+VXZMr7YqP4685dqKC9P4UBE+PQEMFXms
         IZQ4CZANe2UxJqBCrvmoumV+yY8LIevwOBJqGi6o=
Date:   Fri, 11 Sep 2020 09:41:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai(A)" <yekai13@huawei.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] uacce: fix some coding styles
Message-ID: <20200911074144.GA3322797@kroah.com>
References: <1596089583-32687-1-git-send-email-yekai13@huawei.com>
 <a90d4a96-b377-8b24-45a0-c45e5a10dce7@linaro.org>
 <8ebc8b44-eecc-a86f-ce25-ff7513d6aeea@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ebc8b44-eecc-a86f-ce25-ff7513d6aeea@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:37:25PM +0800, yekai(A) wrote:
> Hi Hartman
> 
> Could you help to take this patch?
> Thanks.
> On 2020/7/31 11:09, Zhangfei Gao wrote:
> > 
> > 
> > On 2020/7/30 下午2:13, Kai Ye wrote:
> > > 1. delete some redundant code.
> > > 2. modify the module author information.
> > > 
> > > Signed-off-by: Kai Ye <yekai13@huawei.com>
> > Thanks Kai
> > 
> > Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > 
> > Thanks
> > 
> > 
> 
> 

I see no patch here to take, sorry :(
