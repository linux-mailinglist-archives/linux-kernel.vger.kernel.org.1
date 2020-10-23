Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2355729799F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 01:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758608AbgJWXX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 19:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758520AbgJWXX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 19:23:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B626C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 16:23:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o9so1828131plx.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 16:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OfVT8h9wTg39Kkdz/cTYNaLpjH3zKVjSrnAnLMVOwP0=;
        b=lSvoOZ0BrlQ2aaIRwKZoX+KgWKXDVGWOc2TQ+iLwXjyTbcvzz3q2hQ4sBPZQ3+2uPM
         Uyn4Wa+ret40vchMTDYMZw7LPMi8Jd3+Qvtf5yohR7zQCgwKssECfRopec1uvE9luaZx
         Cw+xk6X3RgJ9vqDLMPha6RpDTeasaxHj/FkA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OfVT8h9wTg39Kkdz/cTYNaLpjH3zKVjSrnAnLMVOwP0=;
        b=rBhqbNoEyWtbh90p5yN51socnRMlWhFZ0oed3o+qraa0gLRgYQ8fbEs9Zyjqa9rl3/
         LYlWzsC/nLliWvSxcDjGc7epVMibdnOke03EjrEJyfWynrznr+LKczCLJjbHVMYG+/ad
         CHlZ7xlisTRAlzqBeRAMvCtAp0S7sd3wkUExSaogdSH8HXSoIb8Sz7NkvEsuRdG6XTLv
         X+6/b8NnQtbN+NyywmZASa3fvFOX0D+mFap8hADXcUb3SZn6k2XlCsNyKsGfzgpUtoDy
         SfbYmVwqiCHIIelgT1b3z1K/mbE8xty67EnFRXW+Wg4NJsHO+9qRcNnMoxPzgag2T58Z
         NSLQ==
X-Gm-Message-State: AOAM533tsbpP6jt7a6go5OvQDUq9cXLiBQfIHUtGEkEo5I/Q/bHCNXKK
        imIKC6lcEH0RuLqTzs8XF5KSmw==
X-Google-Smtp-Source: ABdhPJxUQtoeCUCQzbsz0jKCxEwV0OYgkw3J7AFEwHa0RFT0DIhHaQxFc+KB42j7kNQWqOCOQ90AYQ==
X-Received: by 2002:a17:90a:66cc:: with SMTP id z12mr5453371pjl.145.1603495405901;
        Fri, 23 Oct 2020 16:23:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id v17sm3789476pjy.40.2020.10.23.16.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 16:23:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org
Cc:     andrea@borgia.bo.it, kai.heng.feng@canonical.com,
        linux-input@vger.kernel.org, swboyd@chromium.org,
        hdegoede@redhat.com, Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: HID: i2c-hid: Label this binding as deprecated
Date:   Fri, 23 Oct 2020 16:22:52 -0700
Message-Id: <20201023162220.v2.1.I45b53fe84e2215946f900f5b28bab1aa9d029ac7@changeid>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Rob Herring [1], we should have a device-specific
compatible string.  This means people shouldn't be using the
"i2c-over-hid" compatible string anymore, or at least not without a
more specific compatible string before it.  Specifically:

1. For newly added devices we should just have the device-specific
   device string (no "hid-over-i2c" fallback) and infer the timings
   and hid-descr-addr from there.

2. If there's a need for a device tree to be backward compatible, we
   should list the device-specific compatible string and add the
   "hid-over-i2c" fallback and the various timings.

[1] https://lore.kernel.org/r/20201019211036.GA3595039@bogus

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("dt-bindings: HID: i2c-hid: Label this binding as deprecated") new in v2.

 Documentation/devicetree/bindings/input/hid-over-i2c.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index c76bafaf98d2..733a5f053280 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -1,5 +1,8 @@
 * HID over I2C Device-Tree bindings
 
+WARNING: this binding is deprecated.  Instead of using this, create specific
+bindings for each hid-over-i2c device.
+
 HID over I2C provides support for various Human Interface Devices over the
 I2C bus. These devices can be for example touchpads, keyboards, touch screens
 or sensors.
-- 
2.29.0.rc1.297.gfa9743e501-goog

