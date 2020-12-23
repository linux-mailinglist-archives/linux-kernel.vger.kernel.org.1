Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E748E2E1538
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 03:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgLWCs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 21:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbgLWCsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:48:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB088C061794;
        Tue, 22 Dec 2020 18:48:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id f9so9530785pfc.11;
        Tue, 22 Dec 2020 18:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+PL75IV1YIOve5Jg9V8yrYGzWUBBJbAWUFCp/xwOrcw=;
        b=p0s/urqh8Vx0Vgs8W2NcMs80gJsnxRCC1jlOJH5PKFFFJ8c8bTADFis/oHZ9ZTidWa
         HcT3xHBlkLvT9HwRUjhRhpffGd9F42GGOa9XG3WEYj2L4CIjUxC8C4S6vRYGCauBDhXV
         JjuBq3y4yhhOBesUJLHkYv1a18jax0IfWW6zQnGo4EUpgULI1KA88Ig2dIX4u4Kz4G4s
         bjODtJ8A5SASKSSh3R9otp0j1P/99wf8i2CRtnAaJsP1jjcohC7CUTny9HRkaVu2yta7
         zCZ9PxWyil7FXvYdAef8KDyJ0pn0/ir2+gNXjBXqgTabASB5/6Wpke6piVEOD+/1Eei1
         z1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+PL75IV1YIOve5Jg9V8yrYGzWUBBJbAWUFCp/xwOrcw=;
        b=ZHDoT4PYiEnmVImQk+IZ9WlJ9juWZDtz2sTf0lOoTIebuYNmOeVJZDtWkcXGDnBAJ0
         f5o1ErfKiyvTyQEIe3ZkTcVcxsq22N1I+J6mE/pzqS9Vyp6sHf6ZYnVgxKHnp4Oy7z/z
         57vHQf1fF5/B1NL0VYHTE+UFB4qXZYK97vvi9Fg/8Eoo10AR24UmMVOaVdTn45I2AAwW
         UtKDed/2hVN56DjPq9oP9SMWPFJaIdezA16YBUsIfP7TUsLdqe7dnHZqL2bJrYAHeMXu
         KyrOhLBnrR0GHmQZP8UzxCgD1jrvEzxlRY+05yiC9OxMsTmCrwpHyP+gicLTPKAOnWCe
         qJFw==
X-Gm-Message-State: AOAM530/L7DFpD3Ci50FOp3iiPEejBETVYxuPbggQqb0Vd+/RUvFdbX4
        L90KkyBn6Tl+rj+yaRSh/cY6qrlve4U=
X-Google-Smtp-Source: ABdhPJzzRUw15Y3l8aYDZrE5BwmmYrfjOeWjbCjMBEKO8TbxkfCsaquNLvgH9mJqutbVODIKDFvd0A==
X-Received: by 2002:a63:af50:: with SMTP id s16mr22903348pgo.448.1608691692119;
        Tue, 22 Dec 2020 18:48:12 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm21796984pjb.18.2020.12.22.18.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 18:48:11 -0800 (PST)
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: Add optional interrupt to
 smc/hvc SCMI transport
To:     Jim Quinlan <jim2101024@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201222145603.40192-1-jim2101024@gmail.com>
 <20201222145603.40192-2-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <62da340d-282a-b3cf-5366-18617c03e513@gmail.com>
Date:   Tue, 22 Dec 2020 18:48:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201222145603.40192-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2020 6:56 AM, Jim Quinlan wrote:
> In normal use of smc/hvc transport in SCMI the message completion is
> indicated by the return of the SMC call.  This commit provides for an
> optional interrupt named "a2p" which is used instead to
> indicate the completion of a message.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
