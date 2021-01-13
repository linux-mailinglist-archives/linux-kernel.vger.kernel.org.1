Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3992F4ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbhAMPbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:31:17 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38577 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhAMPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:31:16 -0500
Received: by mail-oi1-f177.google.com with SMTP id x13so2513442oic.5;
        Wed, 13 Jan 2021 07:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXeUcE0h/dzvnnqZWYVCwAZVkRO+AYa6kG7k/p+CyFA=;
        b=qGDm2YKQa7DiaysFwnq8ue6MWXFY0RdQdBykHFEYkTWrbu6v4YyXeaO1QaETEfI+6M
         ohjeCoysju8w91+F4LFdq5l95jOzywAh2VoJzqf+CpRchQZn1LlmRpX5Rp5DlgIQ1NBd
         l6ffboJfDq962CCff9kDAb/Ksv50co7AXKDGLe2NC262d/iWIED7+0HN9Gr6+xhn8KmU
         6BJTJsoIcFF+vMNfewM6RoRqO8CL/EXDxFhSmkSvMnD+Ym5Qbz1R48vC9MyO5PidhhRd
         wsfLl6HXaSduYBiG7XUsCUSS5HDZCvQFxYlAi1b6R5U1naZcMl3dRhYzN7VQ/NswXOrZ
         UKXA==
X-Gm-Message-State: AOAM530psfcZx1Wt2CTa9184gKKVNiaPZkSuB/d1a95Hg9Jjv0TtrzmI
        OdvMtQMsLpYpI6QloOOs3w==
X-Google-Smtp-Source: ABdhPJwOgYfbGGuoFYtYPCMXJp2tGty9cCXvLQNHq7PwOOjKQOaX3FtPI7I2ccsJsZttW49KVkumaA==
X-Received: by 2002:a54:4787:: with SMTP id o7mr1571234oic.113.1610551835778;
        Wed, 13 Jan 2021 07:30:35 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a15sm438043oii.50.2021.01.13.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:30:34 -0800 (PST)
Received: (nullmailer pid 2483540 invoked by uid 1000);
        Wed, 13 Jan 2021 15:30:33 -0000
Date:   Wed, 13 Jan 2021 09:30:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Philip Chen <philipchen@chromium.org>
Cc:     swboyd@chromium.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dianders@chromium.org, dmitry.torokhov@gmail.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Create macros for cros-ec
 keymap
Message-ID: <20210113153033.GA2483483@robh.at.kernel.org>
References: <20210108172316.v4.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108172316.v4.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021 17:23:31 -0800, Philip Chen wrote:
> In Chrome OS, the keyboard matrix can be split to two groups:
> 
> The keymap for the top row keys can be customized based on OEM
> preference, while the keymap for the other keys is generic/fixed
> across boards.
> 
> This patch creates marcos for the keymaps of these two groups, making
> it easier to reuse the generic portion of keymap when we override the
> keymap in the board-specific dts for custom top row design.
> 
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Rename CROS_STD_NON_TOP_ROW_KEYMAP to CROS_STD_MAIN_KEYMAP
> 
>  include/dt-bindings/input/cros-ec-keyboard.h | 103 +++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 include/dt-bindings/input/cros-ec-keyboard.h
> 

Acked-by: Rob Herring <robh@kernel.org>
