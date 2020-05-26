Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536841B60C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 18:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgDWQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729603AbgDWQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:26:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B567C09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so1511135pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dPW9lg0yEN6UpDTKstylSuvl3OH/2pBPj9LaxkywyA=;
        b=G8lOVeP0qxvOsyFHiAAWlAcfYFdO3DFRD0auCPHDOmN+3bjo+IGRmeQgbYIwjCdk+t
         vMLhHo8Fg8Hh5z1SVY+do5Vkly0bRcLVJoLkW8SlLPrQD4KpbuSnqSfJGTX76Xdz5MFE
         RTVGUgnoa97/Vnz+e3+757gFQK3WH57ovzkOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dPW9lg0yEN6UpDTKstylSuvl3OH/2pBPj9LaxkywyA=;
        b=XWornq6xfYK/2x7yLMatpYb8fLX5kUHl90QiwNj3beD9oqZYTz/G28jptHtoPXNsqx
         8zrGVcWAwwsaJ8V4bbaT0JtiLKdB/DkPFNzs05Q2r0dXDpGBbDircHHMJY5c/bj3hRFu
         FE1/UgbasgexzrtIKGr66tvO6jvT+hJX1UsRwD1bdM5L45EmXH0cls3Ssn885hINhSpS
         mt9nij5EoUWpwJAPIl6Xm4DlPfJS8YwuTemCaW54rBLqOUURjEAVzeG5EgSvQRDWYcVv
         T/TbukMsTnh5+IN3r8KQ+V92Ku6xISMSp6xHG17ahfzVHe0OxMHIDZsK8Iz1wM9M+hID
         tOQQ==
X-Gm-Message-State: AGi0PubvnlVQTEbK1C/l5ow5u9cgycIgJG2n0Q4AEJ3R64xmfJyfPx/d
        4curcc9SzWrNhOfNe2kP1uPcrg==
X-Google-Smtp-Source: APiQypJdiYDUHi+oU12ax0Gqxa3QS23u1ChWBrvQSZw3vTUsJak7uOfgLrTMHq4j4e1RNVV3QevUBw==
X-Received: by 2002:aa7:8a9a:: with SMTP id a26mr4225683pfc.77.1587659170761;
        Thu, 23 Apr 2020 09:26:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d12sm2841927pfq.36.2020.04.23.09.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 09:26:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@chromium.org, jernej.skrabec@siol.net, jonas@kwiboo.se,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] drm: Prepare to use a GPIO on ti-sn65dsi86 for Hot Plug Detect
Date:   Thu, 23 Apr 2020 09:25:42 -0700
Message-Id: <20200423162548.129661-1-dianders@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As talked about in commit c2bfc223882d ("drm/bridge: ti-sn65dsi86:
Remove the mystery delay"), the normal HPD pin on ti-sn65dsi86 is
kinda useless, at least for embedded DisplayPort (eDP).  However,
despite the fact that the actual HPD pin on the bridge is mostly
useless for eDP, the concept of HPD for eDP still makes sense.  It
allows us to optimize out a hardcoded delay that many panels need if
HPD isn't hooked up.  Panel timing diagrams show HPD as one of the
events to measure timing from and we have to assume the worst case if
we can't actually read HPD.

One way to use HPD for eDP without using the mostly useless HPD pin on
ti-sn65dsi86 is to route the panel's HPD somewhere else in the system,
like to a GPIO.  This works great because eDP panels aren't physically
hotplugged.  That means the debouncing logic that caused us problems
wasn't really needed and a raw GPIO works great.

As per the above, a smart board designer would realize the value of
HPD and choose to route it to a GPIO somewhere on the board to avoid
the silly sn65dsi86 debouncing.  While said "smart designer" could
theoretically route HPD anywhere on the board, a really smart designer
would realize that there are several GPIOs on the bridge itself that
are nearly useless for anything but this purpose and route HPD to one
of those.

This series of patches is intended to allow the scenario described
above.

This patch has been tested on a board that is not yet mainline.  On
the hardware I have:
- Panel spec says HPD could take up to 200 ms to come up, so without
  HPD hooked up we need to delay 200 ms.
- On my board the panel is powered by the same rail as the
  touchscreen.  By chance of probe order the touchscreen comes up
  first.  This means by the time we check HPD in ti_sn_bridge_enable()
  it's already up.  Thus we can use the panel on 200 ms earlier.
- If I measure HPD on this pane it comes up ~56 ms after the panel is
  powered.  This means I can save 144 ms of delay.

Side effects (though not main goals) of this series are:
- ti-sn65dsi86 GPIOs are now exported in Linux.
- ti-sn65dsi86 bindings are converted to yaml.
- Common panel bindings now have "hpd-gpios" listed.
- The simple-panel driver in Linux can delay in prepare based on
  "hpd-gpios"
- ti-sn65dsi86 bindings (and current user) now specifies "no-hpd"
  if HPD isn't hooked up.

Changes in v3:
- Becaue => Because
- Add a kernel-doc to our pdata to clarify double-duty of gchip_output.
- More comments about how powering off affects us (get_dir, dir_input).
- Cleanup tail of ti_sn_setup_gpio_controller() to avoid one "return".
- Use a bitmap rather than rolling my own.
- Remind how gpio_get_optional() works in the commit message.
- useful implement => useful to implement

Changes in v2:
- ("Export...GPIOs") is 1/2 of replacement for ("Allow...bridge GPIOs")
- ("dt-bindings: display: Add hpd-gpios to panel-common...") new for v2
- ("simple...hpd-gpios") is 1/2 of replacement for ("Allow...bridge GPIOs")
- specification => specifier.
- power up => power.
- Added back missing suspend-gpios.
- data-lanes and lane-polarities are are the right place now.
- endpoints don't need to be patternProperties.
- Specified more details for data-lanes and lane-polarities.
- Added old example back in, fixing bugs in it.
- Example i2c bus is just called "i2c", not "i2c1" now.
- ("dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd") new for v2.
- ("arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza") new for v2.

Douglas Anderson (6):
  drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
  dt-bindings: display: Add hpd-gpios to panel-common bindings
  drm/panel-simple: Support hpd-gpios for delaying prepare()
  dt-bindings: drm/bridge: ti-sn65dsi86: Convert to yaml
  dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd
  arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza

 .../bindings/display/bridge/ti,sn65dsi86.txt  |  87 ------
 .../bindings/display/bridge/ti,sn65dsi86.yaml | 285 ++++++++++++++++++
 .../bindings/display/panel/panel-common.yaml  |   6 +
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |   2 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         | 194 ++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  53 ++++
 6 files changed, 540 insertions(+), 87 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml

-- 
2.26.1.301.g55bc3eb7cb9-goog

