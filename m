Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72AD1EFD03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 17:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgFEPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 11:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgFEPtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:49:05 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 452742075B;
        Fri,  5 Jun 2020 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591372144;
        bh=fhSt8gBcDKl/O32yutyXIRsQjRoka5UOjtiH/O+HNYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zO5eW9+ujVmT1pbL8ggccexkpzKTaRApk39lxGxqG3pXPm6IPBHZ+kpNv+vYK5iXB
         8UiPoCrjnL0rIYfSPY+Nh33lIane1O/Ab3grbL8as3a3E9AtvlPagloPWhQZ6V0BQo
         yVJ60rCRw++obLeqDRlOCVxbYWaNE9ScFcOG0ZMc=
Date:   Fri, 5 Jun 2020 08:49:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wangzhou1 <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: Re: [PATCH] crypto: hisilicon - fix strncpy warning with strlcpy
Message-ID: <20200605154902.GA1373@sol.localdomain>
References: <202006032110.BEbKqovX%lkp@intel.com>
 <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
 <20200604033918.GA2286@gondor.apana.org.au>
 <b6ad8af2-1cb7-faac-0446-5e09e97f3616@linaro.org>
 <20200604061811.GA28759@gondor.apana.org.au>
 <b23433f8-d95d-8142-c830-fb92e5ccd4a1@linaro.org>
 <20200604065009.GA29822@gondor.apana.org.au>
 <f8dceec5-6835-c064-bb43-fd12668c2dbb@linaro.org>
 <20200605121703.GA3792@gondor.apana.org.au>
 <47b747d2-3b27-4f39-85c9-204c2b8a92e1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47b747d2-3b27-4f39-85c9-204c2b8a92e1@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:26:20PM +0800, Zhangfei Gao wrote:
> 
> 
> On 2020/6/5 下午8:17, Herbert Xu wrote:
> > On Fri, Jun 05, 2020 at 05:34:32PM +0800, Zhangfei Gao wrote:
> > > Will add a check after the copy.
> > > 
> > >          strlcpy(interface.name, pdev->driver->name, sizeof(interface.name));
> > >          if (strlen(pdev->driver->name) != strlen(interface.name))
> > >                  return -EINVAL;
> > You don't need to do strlen.  The function strlcpy returns the
> > length of the source string.
> > 
> > Better yet use strscpy which will even return an error for you.
> > 
> > 
> Yes, good idea, we can use strscpy.
> 
> +       int ret;
> 
> -       strncpy(interface.name, pdev->driver->name, sizeof(interface.name));
> +       ret = strscpy(interface.name, pdev->driver->name,
> sizeof(interface.name));
> +       if (ret < 0)
> +               return ret;

You might want to use -ENAMETOOLONG instead of the strscpy return value of
-E2BIG.
