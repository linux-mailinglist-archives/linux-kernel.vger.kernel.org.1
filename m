Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8347521C9E0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgGLOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgGLOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 10:53:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B798CC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XPXkvub6jYBBBPAyd6pzdUrw1T3+QKSiI+YpVc2oq0E=; b=IUO7qseVzERi5xQYWx5eTdTOAo
        UHEMFNirvgCkhALH2FhJJU2wGrQkXAvcjKiJ9xC8NNOEprl2oBe+dXJmzxiUeGiNiph4WddkJROJW
        KrV38pxRPUbIuCPJZlVjoIX54Yh2U4bkmRmSMX9zfUUnBFchkpQfyUqSP2KV4atTj4GExFh+HJQUO
        BsBB9IxpWse93Wo2cxtyb3MlEWhdLQLTX+l0LWbAjCPvpzbSG4LwXKnFOP1vUdj0u0bNw3HG6XECe
        2NIeGYVK9pR0W7LUARqFYoGNjqBZWYsJzH3naaIOcsPvWRSEUMhU/KV78q+PYfmyCplBBuA8cgFjA
        ii2QQ+wQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1judMO-0004bo-Eo; Sun, 12 Jul 2020 14:53:44 +0000
Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
To:     Gage Eads <gage.eads@intel.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b25e3544-d975-b966-5374-639401541e59@infradead.org>
Date:   Sun, 12 Jul 2020 07:53:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200712134331.8169-5-gage.eads@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/20 6:43 AM, Gage Eads wrote:
> +int dlb2_ioctl_dispatcher(struct dlb2_dev *dev,
> +			  unsigned int cmd,
> +			  unsigned long arg)
> +{
> +	u16 sz = _IOC_SIZE(cmd);
> +
> +	if (_IOC_NR(cmd) >= NUM_DLB2_CMD) {

Does this bounds check need to use array_index_nospec()
from <linux/nospec.h> ?

> +		dev_err(dev->dlb2_device,
> +			"[%s()] Unexpected DLB command %d\n",
> +			__func__, _IOC_NR(cmd));
> +		return -1;
> +	}
> +
> +	return dlb2_ioctl_callback_fns[_IOC_NR(cmd)](dev, arg, sz);
> +}

I don't know if it needs to or not. I just want to make sure
that you or someone has thought about it.

-- 
~Randy

