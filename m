Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73DB2E8001
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 13:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgLaMuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 07:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgLaMub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 07:50:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C00C061575
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:49:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 190so7274298wmz.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jamieiles-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+u96/FdXtTHmr5sq3JveWFw2+/26Jf5HarPYw8gvYCs=;
        b=LRifIyWKZ8eOFZxIGtpU/YPzV43QhXZop2mhbgMeq2j1tJmIEss1L8YfY/wZQzkb+H
         HyhZWcw1B5hI4ZkYVss8CObpO9qKeGPyWTH978tGg37pSCPJlzs1ea0ezfqY8XXyFH16
         K4a3UaO++OmVgGpJuk4WWwyTixpmUWvYecKa6b5FQrENGKFrNQDBhKL3bdiFtK32UMpm
         vi/NjDURR80NlUYY6siwN7Pxwpz6IlZz3ZSh92QiIeiGvVkMKMdjh9tjRqr1+ma3CTBy
         8UFB1cZxKQ8Lma3mRhL2AYlzFeESkAkNbonYqHHJxltr85w5Zr5wQu6YkSmOezjZYzF0
         4uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+u96/FdXtTHmr5sq3JveWFw2+/26Jf5HarPYw8gvYCs=;
        b=PgF3cPQVfDP5+bnSvdjmtVjg4EPaVEoGSn0FSa92pG13784nxK8bdmwnMHy85kiCo8
         TqdJWiHu6d7TUJS/tWjiiD+b/yVyMvspLwh9Cf2evkgbdEXllDP8meSWfWBT8WwvFhbC
         AsdTeArfibs0Iv8eYyTReqQqFNCp0ATibdPhJDAPGKgPP9BhIhJb54G0Urw/Vz7be4MW
         R/qKt/204zmzN3rOq98sBq6I1s62YqU478Wchdf3puceyVKa3/Sb1PNeJibNRlRrlzhK
         lD3q7A+nTEkJcc4BkAyYXiBGoNbKbmtxiAUCNNjmZ9jYz0Po3XQ71VvXZa1Rc+g36vG6
         t5Mw==
X-Gm-Message-State: AOAM532SiLFdsVXCeEM/gNibtKcYhsXnTDLXb/kFwqSj8RrlN8XQMfqO
        o0VBvavsVt3FbBV/SiOOsvOpFA==
X-Google-Smtp-Source: ABdhPJyaaWOCxYGSn5WfpQxWYXqZdpY4FkOhFAEAmVOwUHvAIspHxZt2IHTzFJ/vdcbAAwb8EbljbA==
X-Received: by 2002:a1c:ba07:: with SMTP id k7mr11943033wmf.34.1609418987858;
        Thu, 31 Dec 2020 04:49:47 -0800 (PST)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id h15sm68233268wru.4.2020.12.31.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:49:46 -0800 (PST)
Date:   Thu, 31 Dec 2020 12:49:46 +0000
From:   Jamie Iles <jamie@jamieiles.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jamie Iles <jamie@jamieiles.com>, Rob Herring <robh+dt@kernel.org>,
        soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: picoxcell: fix missing interrupt-parent properties
Message-ID: <20201231124946.GA2918779@willow>
References: <20201230152010.3914962-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230152010.3914962-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Dec 30, 2020 at 04:20:05PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> dtc points out that the interrupts for some devices are not parsable:
> 
> picoxcell-pc3x2.dtsi:45.19-49.5: Warning (interrupts_property): /paxi/gem@30000: Missing interrupt-parent
> picoxcell-pc3x2.dtsi:51.21-55.5: Warning (interrupts_property): /paxi/dmac@40000: Missing interrupt-parent
> picoxcell-pc3x2.dtsi:57.21-61.5: Warning (interrupts_property): /paxi/dmac@50000: Missing interrupt-parent
> picoxcell-pc3x2.dtsi:233.21-237.5: Warning (interrupts_property): /rwid-axi/axi2pico@c0000000: Missing interrupt-parent
> 
> There are two VIC instances, so it's not clear which one needs to be
> used. I found the BSP sources that reference VIC0, so use that:
> 
> https://github.com/r1mikey/meta-picoxcell/blob/master/recipes-kernel/linux/linux-picochip-3.0/0001-picoxcell-support-for-Picochip-picoXcell-SoC.patch
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Rob has a series to remove Picoxcell as there's no active development on 
this anymore and Intel have stopped producing the chips.

Thanks,

Jamie
