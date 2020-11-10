Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92212ADED2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgKJSxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:53:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43932 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJSw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:52:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id b9so13915401edu.10;
        Tue, 10 Nov 2020 10:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qFYHq+JAYlgGgKeMt0sIqJhYAgHBuCUoDc438Vz83/Q=;
        b=oMyfifLFQRv3stMwbxaLgLOxb1Cr0RIA3Ht7Ao9rvaX+6I0P/XJF3MIVc9Yvd3CQmk
         KgrRuFr+8r/Dj2D1q1PCgeezW7MVWXPHxgOqYomGciKNpGg5E1cFglVSKf5URu0hXmCS
         1lCF3I/QYOUC9mLhvY9V5m5PAsRKaj/Liup7wTtDv1AcBUyfnerQOBlBTAtQOVzKKfRc
         J7xvF98hpptN4JKzI8wNULyFQuvNgwEF05Muo28znMMZgGc3x8MU5thECiYHSiVVntIc
         nssJ+6htrQKWnDYlcEWHqjtTPhqFq6XaNdQB5/A32ehXOfVB+1yWT4LnvLzQ4+G7dBey
         z8Fw==
X-Gm-Message-State: AOAM530X0+Ai+Rru5uigvAkq3cN3HvYG2S1dZKRmSyrAO1/fxbEOWmsp
        U7asIGQB2cXSwB/CU2ewOi0=
X-Google-Smtp-Source: ABdhPJzyeVvjIqNDtzgkS0g3WgTJMxXYFWnGvd0ZeG9LXfMEQ8cDg9+qji5Abp6tz5w7tQZnBStX7g==
X-Received: by 2002:aa7:dd4a:: with SMTP id o10mr805227edw.109.1605034377269;
        Tue, 10 Nov 2020 10:52:57 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a3sm11638763edl.89.2020.11.10.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:52:56 -0800 (PST)
Date:   Tue, 10 Nov 2020 19:52:54 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add dt-bindings to mailbox entry
Message-ID: <20201110185254.GA37445@kozik-lap>
References: <20200903195325.5394-1-krzk@kernel.org>
 <20200903195325.5394-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903195325.5394-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:53:25PM +0200, Krzysztof Kozlowski wrote:
> Cover the dt-bindings of mailbox drivers by mailbox maintainers entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch

Jassi,

Any comments on this patch?

Best regards,
Krzysztof
