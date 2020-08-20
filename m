Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3324C5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHTSwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 14:52:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgHTSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:52:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so3137212wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJ095o2R3pfLHrGrBkg75D4r4m29RUPbdiOfPVS83Ok=;
        b=q7QgR74Ox6vR+DfxgQTlpAUjOAHdFQ/d5J3xL9N4RmSLZxD3OOYIjGZoGNxPaxjmDv
         whahzFOBXE0MfhQtKDlV5pqf6dvw2j5BhJtZIh1BArDbxll5emGL1GKX3zsAumfH1zj/
         67WA7YrhVYRF6jVl/WK9HkgF2bew+VzPAT0cKWm5ykdxfEZ9nUCxBcM9+6jrAfw0emkM
         AtkyyACw3SqUAKGstklDzQOfsEMlML/38HNV2jr3GQpi0KugDXprESU/h1O8R7fIF/JP
         ljULnJ1a11jICOs1F3yM6gTtwkuI1WWnOil82G/vHBE9F4TFFqqS+7YlYRpSXUOZU8cq
         KFEw==
X-Gm-Message-State: AOAM532OOF4Eizvv+dFgeuIgzd1LQwmaLM7vUwFxgOxAXKKprsBOPpzL
        vH9UxAn29YMrMFiRZe31D+I=
X-Google-Smtp-Source: ABdhPJzkDPZAouwqIHWPOQHYosJiqPAJhKrgroO2UbF2yZfw92R8S8xfuBRKKq1Q9umYszmavSEPPw==
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr111645wrs.302.1597949563855;
        Thu, 20 Aug 2020 11:52:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m20sm22707438wmc.1.2020.08.20.11.52.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 11:52:43 -0700 (PDT)
Date:   Thu, 20 Aug 2020 20:52:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: Fix memory leak
Message-ID: <20200820185241.GA2833@kozik-lap>
References: <20200820172118.781324-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820172118.781324-1-alex.dewar90@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 06:21:18PM +0100, Alex Dewar wrote:
> In brcmstb_dpfe_download_firmware(), memory is allocated to variable fw by
> firmware_request_nowarn(), but never released. Fix up to release fw on
> all return paths.
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
> v2: Don't assign ret unnecessarily (Krzysztof)
> ---
>  drivers/memory/brcmstb_dpfe.c | 16 ++++++++++------

Thanks, applied with acks, CC stable and Fixes tag.

Best regards,
Krzysztof

