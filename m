Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4C1A8C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 22:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633139AbgDNUbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633128AbgDNUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:30:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:30:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v23so478290pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=fSEFHqlQPWjh+eO1zQvk6FlxgyhPbRWA0nRwzXY+ICo=;
        b=DI0GDNcWCaSKUzojr44APUQ2g87h7tlXam1IW/LVnZhwiGN7iX2KJtlZI5R+UiNDfu
         DZF+uvx/5gEssBaQxrGn4yJQ3UomR6yu12eYC9INAa7bhWe6L3xj6e4qV1jmHXr+apyW
         1Br2PWFOsLPo73h3of8BD4ggO6KRXWFIckqv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=fSEFHqlQPWjh+eO1zQvk6FlxgyhPbRWA0nRwzXY+ICo=;
        b=Izlfx9gkcgM218ktzEfStuIhPdjM1TB7CW7hHdTKfVeKmyBbQaQlE1DoS/ihG4sNNR
         REL05HeGbPvI6IFC5POM1yozQFkPKP6y9OYzLeWWiP5/2EJrKs57DIYyjAVLHyempbnB
         aB4iEmUHGcOiEYLstXrfdNe8N4Z8e28R6NWuYr08SxnjDBERlvPPMJArR5xYekvXfGOJ
         H0a3eL3/IA0DBchfJfxCRyWrKonp9vk8uo8bhaOHtV3xWMGn03+zth5Say+Z8GkAlQ0T
         WSQiLGB0OwEISf2wmBjthBwRG14FnPsL/VQNUjeJoqth0HDnHPdjBaC6Semu4Kyk6J6d
         gCyw==
X-Gm-Message-State: AGi0PuaZkuT1297XajsvMLf0ItqOIwKQws78tVTBxJstuxwkvRm33lBf
        M6TR+/qCW5g73vQ69q/qQ/PrZk/Kaeg=
X-Google-Smtp-Source: APiQypK7j30AyIlG7FThLusdHeZXiMK6nQsQdNpWtZSQ6V+9S0RcjrpG2nccWcW5xJlP3E2y/EjX+A==
X-Received: by 2002:a62:27c2:: with SMTP id n185mr24066849pfn.203.1586896248214;
        Tue, 14 Apr 2020 13:30:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m3sm11025978pgt.27.2020.04.14.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:30:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1585718145-29537-2-git-send-email-sanm@codeaurora.org>
References: <1585718145-29537-1-git-send-email-sanm@codeaurora.org> <1585718145-29537-2-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v7 1/4] dt-bindings: usb: qcom,dwc3: Introduce interconnect properties for Qualcomm DWC3 driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Date:   Tue, 14 Apr 2020 13:30:46 -0700
Message-ID: <158689624666.105027.3280804524840557421@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-03-31 22:15:42)
> Add documentation for the interconnects and interconnect-names
> properties for USB.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
