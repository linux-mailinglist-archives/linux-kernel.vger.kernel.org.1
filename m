Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7921B7AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgDXPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgDXPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:54:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14247C09B047
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:54:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so11492192wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1PV7wNlDdMH3OuiuS+RgGXP0VXIxRvRVyjRNbcZpO3I=;
        b=G3O5xC+RvIP6f1BcmRIkj0/94vJA4D3RR/OKZ0IK2WHI8deiUNnnii7U/1XEuSENAY
         pjUhqGHJakehwK3dflf9xjpY7FpaQCetehRVu8pcakwmDQ7Fp9oG/hVDHcdzD+paYXgX
         lNUM6fM5C5o7k90OSnoHPYH96Hv/zqS6vRPajTKA01JmgSNIrQXbfgwU7Dn3bXJ1DaOQ
         syswUFhjJVfZ2X6pnPD9+ZGlZEO8PN1np6mb83YgvxneDoErTSj1ETwppcNxAbhyoug6
         OORcrxEfmkgUrGb4jXTeG3UNc28uzS9ccIWvQAq5igfxgKyS8i807jaSQMatGsrm7uy1
         gssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PV7wNlDdMH3OuiuS+RgGXP0VXIxRvRVyjRNbcZpO3I=;
        b=P9GMvjDBAVbwGp4VCKLKF2JKrH1zHEmLTtidt8FWJ5VzeQvAImep4ilO8YTg1uiaU3
         1Zt0eu6BpUNDqnc5JoRoXnFqvPp+Zw3UWIxUyXjJwdlGTOsY/0s52x4bBU5G8NMYqc0Z
         SlFVGjBpyBx1m6CKBtSlA/OuQEUjIkwuqfeI5bjXi9emiDKYpNEGEtJVi4EEJWRRA1oI
         2YtgrPsKzyE9S50ZI7aQO8FgUU5SBgzh1IybP3x7YASNCh4qCJwU11tcFtQLN/hr6kFE
         j5VYE0GoJStqF95/yPVzxbLojMG5aw3NP0JNr9koTCY4G6OI++f1WVRIwY2zW6D4o0z/
         0yyQ==
X-Gm-Message-State: AGi0PubsVPrkJq50ZAMNtOfSeQB8BpDMXXGAfLYhoERkZIjjslEsD6pl
        b9vNjjQqG87P110NbsOrz3ordg==
X-Google-Smtp-Source: APiQypKhRF4rK1iG14uisWyxXPjB4ykbVFGRxPgex9UUwbyA2dNx4mc0hwYcw4mhmIWGA5i2uyZLbg==
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr11757587wrw.389.1587743647735;
        Fri, 24 Apr 2020 08:54:07 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id z76sm3923583wmc.9.2020.04.24.08.54.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:54:07 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v7 1/7] dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
Date:   Fri, 24 Apr 2020 18:53:58 +0300
Message-Id: <20200424155404.10746-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200424155404.10746-1-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

Interconnects often quantify their performance points in terms of
bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
allow specifying Bandwidth OPP tables in DT.

opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
tables.

opp-avg-kBps is an optional property that can be used in Bandwidth OPP
tables.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v7:
* I have dropped Rob's Reviewed-by, because of the minor change below:
* In order to store the bandwidth values for multiple paths, the
opp-peak-kBps and opp-avg-kBps are now defined as arrays of integers,
instead of just integers.
* Improved wording (Viresh)

v6: https://lore.kernel.org/r/20191207002424.201796-2-saravanak@google.com

 Documentation/devicetree/bindings/opp/opp.txt | 20 ++++++++++++++++---
 .../devicetree/bindings/property-units.txt    |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 68592271461f..a8a6a3bfcfcb 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -83,9 +83,17 @@ properties.
 
 Required properties:
 - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
-  required property for all device nodes but devices like power domains. The
-  power domain nodes must have another (implementation dependent) property which
-  uniquely identifies the OPP nodes.
+  required property for all device nodes except for devices like power domains
+  or bandwidth opp tables. The devices which don't have this property must have
+  another (implementation dependent) property which uniquely identifies the OPP
+  nodes.
+
+
+- opp-peak-kBps: Peak bandwidth in kilobytes per second, expressed as an array
+  of 32-bit big-endian integers. Each element of the array represents the
+  peak bandwidth value of each interconnect path. The number of elements should
+  match the number of interconnect paths. This is a required property for
+  bandwidth OPP tables.
 
 Optional properties:
 - opp-microvolt: voltage in micro Volts.
@@ -132,6 +140,12 @@ Optional properties:
 - opp-level: A value representing the performance level of the device,
   expressed as a 32-bit integer.
 
+- opp-avg-kBps: Average bandwidth in kilobytes per second, expressed as an array
+  of 32-bit big-endian integers. Each element of the array represents the
+  average bandwidth value of each interconnect path. The number of elements
+  should match the number of interconnect paths. This property is only
+  meaningful in OPP tables where opp-peak-kBps is present.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index e9b8360b3288..c80a110c1e26 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -41,3 +41,7 @@ Temperature
 Pressure
 ----------------------------------------
 -kpascal	: kilopascal
+
+Throughput
+----------------------------------------
+-kBps		: kilobytes per second
