Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3B1A2A88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgDHUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 16:41:11 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:36464 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgDHUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:41:10 -0400
Received: by mail-lj1-f175.google.com with SMTP id b1so9185154ljp.3;
        Wed, 08 Apr 2020 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQduJrIJ0M6lVkhdvPA5KPzWn/6ZJ/mPlQwccUPG7sc=;
        b=adDCDCEiXZExjvCyStHBQbZ1qFvJehQYRn43WnH3XrG+S4JdGm77jlgVlbSfbbOtAh
         hmdXLcXyNHcrFceAD6IOKZiKRc+l+MdIYdfwjmeUg/D/fP9wAtDG9ahKpNG7lISRAyzV
         U3TVitcO1rfahXKEYVw8amKARXTwI7WMt+FRvqWkEyyB3Ycmf72BtqfQnDhnZFWgAHb2
         k7lXLJr2kUgFDXMZMLlsB1I+MbXlKuOWv6msAXXEt+jZ0DWl1OStvOmhhSk+gBGl5xnp
         5Agl5x10jY9EEbqVyVlXUZ/SxRkvUTvBR1XnoaysUjrIkcLQfRgMyNDHvhoB6HqsUSm3
         mE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQduJrIJ0M6lVkhdvPA5KPzWn/6ZJ/mPlQwccUPG7sc=;
        b=mSkqsEayoymx6XSa/+jxhlgYlMX/tM42JdEL8mwzP5fw6JMDLzKUz+68XOWbAxJaAp
         Uj4xkHcct2Vsj2f3SGsdLmQZn05v0s0sm2zKnSBNDJJdwOlq90it4du8b6CWjAxNkFjr
         fjPYGGykqYpYxoAX23tYxnfY/B0J69skhuR0Oa4LDGxNgWdIhoLXUBTJooGJclbJG0oa
         w85+C5xoKTLt3sY10cSyY9AthH/bfmuj4upEJcKlYXpipq95KFzzD1BA3lD8OCYG02OY
         XmM8w5mQHEVOQnqa90QneHVPy+kEDvXOmawzCmALTOujK1fbi3GAxu2Umn7QL85SKFql
         Li4Q==
X-Gm-Message-State: AGi0PuYFgc9o7HBw1CD9VDb5oT9bQpqHmc9kCQm3W4M6Zalc/gQHOURm
        iz66LL7JSV2tQpM634mc1nk=
X-Google-Smtp-Source: APiQypIHnl1BHhQMnWYNHWtb9wOB24IvIoFqmVA8IndNwohXac8EE9O1Nbyzzaqz3g76SgIWn16vGQ==
X-Received: by 2002:a2e:a16d:: with SMTP id u13mr5965845ljl.140.1586378467430;
        Wed, 08 Apr 2020 13:41:07 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id p14sm13189727lfe.87.2020.04.08.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:41:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Wed,  8 Apr 2020 23:39:42 +0300
Message-Id: <20200408203945.10329-4-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408203945.10329-1-digetx@gmail.com>
References: <20200408203945.10329-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer is a hardware and electronics corporation, specializing in advanced
electronics technology. Acer's products include desktop PCs, laptop PCs,
tablets, servers, displays, storage devices, virtual reality devices,
smartphones and peripherals. Their web site is http://www.acer.com/.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index bf95079a82da..90c178abfa9e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -27,6 +27,8 @@ patternProperties:
     description: Abilis Systems
   "^abracon,.*":
     description: Abracon Corporation
+  "^acer,.*":
+    description: Acer Inc.
   "^acme,.*":
     description: Acme Systems srl
   "^actions,.*":
-- 
2.25.1

