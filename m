Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36743281CDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgJBUVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:21:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F414C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 13:21:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h23so1509229pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QmkyIwIzJZpIkonY93V0qmv9p9tflahwJGcGGSuv9+E=;
        b=rrD1P5O7APb3+Gu0r0gAfZ9ZDM5/V/JUeBgCmqAGYk4yvWkkE47FzAqWXrz04eOdoB
         PThUUMnGwyqG6ums38vD+GaCgdk6BAmr+g9fBeIF1u0H8KP6KhF8O6Lkji/z3Oh/zWfK
         8wnR094h0q6txl7CRf0R/cQS4iPf8wIxnYFwqReXrrgbrS1kt0pB7S1NEf+Pkhh6pmta
         pacQkAjsUjdyHTAHxVrocMINIbBhTXfQIcfQxUlzPjmyzR2VvLqrL3ugcjRYQ0NNIPRt
         jleZKQAEdE4y/76XkSiLwWXQlVXj3LiZNxqaibTA3oAEFxaj/9IuDx//HhCD14pcHj/9
         glAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QmkyIwIzJZpIkonY93V0qmv9p9tflahwJGcGGSuv9+E=;
        b=TYero7SFuaCCfC2NjsUudWbjPUQPeiRaTrFQ0e2uL1SqFaGRnw1KXh6De2UhCJRNiR
         /L/sVFUsQtDcjLKIaxw2r+pPN+thJ429xDxDTXIDuDXDXOp/Dq89QeVeq7R8w5EdCJFp
         yXNHGbgElQk6zfm9Xa09KLZlZaTnQfvGfgTIo85OqMNkwweHRnf9Zjannq1OYTsQj6DC
         i+jX8waUFPZPJK78F6GllTeICCfqNB1mY7LN4oYfB7OC/oUagyoHnzkYGE4hGFVapot4
         GRrjW7ExWs+S08Z3D6EumuElqH16ia5zFPvlgp4tahO/o8s9thZLb+Tzyc+LTR143TFV
         iC/g==
X-Gm-Message-State: AOAM530ItE976Fcb1FraR+VB3Bqo6iSZuQRqjPoN6UvOv7KO1VFnzbNc
        h0lIxKavtP3e9Pq6urz68SU=
X-Google-Smtp-Source: ABdhPJzpo8nb1R3LbTN3IBkwzzxZmrCnKi6lyyEPk+dMqcHrP2s1B0blu6sdI2E9x8ZsILd4VCmxMw==
X-Received: by 2002:a17:90a:8c8d:: with SMTP id b13mr2373981pjo.208.1601670102585;
        Fri, 02 Oct 2020 13:21:42 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k24sm2928388pfg.148.2020.10.02.13.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:21:41 -0700 (PDT)
Subject: Re: [PATCH] phy: usb: Fix incorrect clearing of tca_drv_sel bit in
 SETUP reg for 7211
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20201002190115.48017-1-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <376da218-b185-c9d7-3b53-6c1b08fd4c47@gmail.com>
Date:   Fri, 2 Oct 2020 13:21:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201002190115.48017-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/2020 12:01 PM, Al Cooper wrote:
> The 7211a0 has a tca_drv_sel bit in the USB SETUP register that
> should never be enabled. This feature is only used if there is a
> USB Type-C PHY, and the 7211 does not have one. If the bit is
> enabled, the VBUS signal will never be asserted. In the 7211a0,
> the bit was incorrectly defaulted to on so the driver had to clear
> the bit. In the 7211c0 the state was inverted so the driver should
> no longer clear the bit. This hasn't been a problem because all
> current 7211 boards don't use the VBUS signal, but there are some
> future customer boards that may use it.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
