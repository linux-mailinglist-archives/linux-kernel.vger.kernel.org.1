Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81642DA306
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440808AbgLNWJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:09:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37539 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441080AbgLNWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:07:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id l207so21023159oib.4;
        Mon, 14 Dec 2020 14:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/I65MXMkNznaW5LKxsVjR34sG4yDznp7JKf020+wMs=;
        b=qxddUNS/4OQprr3zCEg0AmEH1dDG/o9Ln0JiKJbQkx3BP7R4jGm+BqR9VZhV0sWKu0
         YyFPKv/G8XhDHp02fsZTmlU0af7E4U6DovB9fvzuh14EZOUR7ztCIgHmkEwPNwpbsS9u
         73jvnHM4FokC58gyP7bYzoaIlcDtKVgJtHYtcXx8Opzm5Cna7IyezLCv6D7SvJtjJ2z2
         8vKdB9w/gdhBadvxmXiQ1WPUWUNXeunWykQWrIRuBYMGDkNZJ9EzbbJ3WFEXS/5caj8j
         ezdOOWmncPG/t/lnLCaP3ncoa7l/61iJooO97ZEEA7E1+h/4d0vmGE+zoeMaDblIwIaC
         vQoA==
X-Gm-Message-State: AOAM533mi/EZOP2D1PXv2+QUMCwc/b9hf/b6dcTEdSYXvHLp9EGQ+LGr
        +J2LmneFbIVVgpeF27Zk6g==
X-Google-Smtp-Source: ABdhPJx+39HYyPsjA6xBoSfU2ve06K7MlTuoJO6hqIby89sUj/Ci9w4qXjJZlysdJqYzOH+JUJHhkA==
X-Received: by 2002:a05:6808:352:: with SMTP id j18mr20177974oie.78.1607983606634;
        Mon, 14 Dec 2020 14:06:46 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f18sm4632704otf.55.2020.12.14.14.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:06:45 -0800 (PST)
Received: (nullmailer pid 2471687 invoked by uid 1000);
        Mon, 14 Dec 2020 22:06:44 -0000
Date:   Mon, 14 Dec 2020 16:06:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     devicetree@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mali-bifrost: Add
 dynamic-power-coefficient
Message-ID: <20201214220644.GA2471636@robh.at.kernel.org>
References: <20201209115143.15321-1-lukasz.luba@arm.com>
 <20201209115143.15321-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209115143.15321-3-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Dec 2020 11:51:43 +0000, Lukasz Luba wrote:
> Add a property dynamic-power-coefficient which allows to register Energy
> Model for the Mali Bifrost devices.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../bindings/gpu/arm,mali-bifrost.yaml          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Applied, thanks!
