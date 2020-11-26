Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA32C53E2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgKZMUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgKZMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:20:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A43C061A47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 04:20:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z7so1933624wrn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 04:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=I1UeLhK5lkQUqckNmvEUJhsql5YPBYYgHazHv8lUUUU=;
        b=uJfDXMDZnxJTIwPzTRofjOQ6csb2iWvSHYxuSNZjQ956VRMK9y4wUe1LNnD2eadr+O
         2BUFCHRIH1okWoDHgKaeGGcKlteYmwFI8/8rLWKeZAY5gVgKloHTfTnhpdWrMftj8h/X
         wZz3edoQ+6WKNoIEUt9l7MGOHo9TOxUDNZ4ft1uRwVYQG+IoC9maSsxlb3UsZSSkzOGa
         MfisXrWQo6aSqZ1TAuSn8LCru83gZreYdYvob/CsrkllRxRbqC68IMHO0WOwLTazxUaJ
         Zs3HB4S+gpSFWV6qJjUClFxm74hpOr+hy3w9UmPh8LhBtVy/xsBqbWl9UZaoSK7zPqOu
         QoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I1UeLhK5lkQUqckNmvEUJhsql5YPBYYgHazHv8lUUUU=;
        b=L9h1PvLIbFuy5YQsLndK6dPFm/1li5h3zRaKOGvAW4pEqVITjIaFUJO0/que14fwxd
         zujDW5QTHT7mwxPOGddFDQdpEpoRcdp2pjMfTB3m1DJ4ka5FTYTt8bzLhh6SwLeLhqPN
         O7usOQCBWBZoQxBHIx565ji+xlkK5oOjy+sXT64h4TYLJjnGcOeljNbZ6ivF/q9rNEaY
         GpEkTrQxMqZlrL5tp0xyr7xg+q9pBe1UyZBq4+3gD5yJdM9dcQ/VKGluTpGEerF2TjOE
         idDZHHHsls2rZPTkYBcaslgnM2fvZ0GcFdTMfU2BGbnsVrM0QwO1FW2hs6+tpfJaMU3q
         W6rw==
X-Gm-Message-State: AOAM530n+NYS9ou9y8ggaPCv3Jfbq+xbR5SGK48gm2mfQjtSYJHvvy6i
        JKdruJ7SkCu1sG2SX6ZQ9W+xUg==
X-Google-Smtp-Source: ABdhPJyFsR5iWagJrLMSBiKU/iHYYfx3vRdcZJkFceccaNGTO2pBE7QpnOJDOLlPaApTXZUHnsN0Lg==
X-Received: by 2002:adf:ec8a:: with SMTP id z10mr3621132wrn.113.1606393238890;
        Thu, 26 Nov 2020 04:20:38 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f5sm9060135wmj.17.2020.11.26.04.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 04:20:38 -0800 (PST)
Subject: Re: [PATCH 0/5] Consolidate RPM interconnect and support to MSM8939
To:     Jun Nie <jun.nie@linaro.org>, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Cc:     shawn.guo@linaro.org
References: <20200930081645.3434-1-jun.nie@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <43318c75-cfe2-d219-2ea4-7a130ea5883b@linaro.org>
Date:   Thu, 26 Nov 2020 14:20:39 +0200
MIME-Version: 1.0
In-Reply-To: <20200930081645.3434-1-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/20 11:16, Jun Nie wrote:
> This patch set split shared RPM based interconnect operation code and add
> support to MSM8939 interconnect.
> 

Hi Jun,

Are you planning to refresh this patchset?

Thanks,
Georgi
