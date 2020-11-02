Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949352A3536
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKBUg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:36:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35775 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:36:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id n11so13912876ota.2;
        Mon, 02 Nov 2020 12:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o49aI9WHH7NAbNkzIi0ty0+QOTQw851+/7lSKbsX7Fg=;
        b=G3AXASqbxOPiHURFlHwnCyXZDMrMpSyQ15zcAOX/+9YXD7TRcJ1xS4yPeZz96S8R1f
         3CMfQDuL/ugV5a+RLd8+YiRhJBztGvWtLyoQetVEOlsjH57Nq+BGyTGFQbnRekF5BPXI
         Xp0/YodgEWZ3FCRg+Gso6Xw2coD8wKeHUymYctZvQY4BjL6NDxynIZWaDsPAjkmWfgCx
         4RqRApEbiApEf1rXx8rWAlcgwTE8QFnE/32znfozH+ioz4/1QGy4BpuI94dgUi+T3+LZ
         iZTKEl00Di/jNoy+1YSpI4LsKiZCdxQHTKQlpO8DE3Dy2DDVJi85npzi2tIXq9i/tTSc
         QOJQ==
X-Gm-Message-State: AOAM532UuC6Aycw0jKiIAqSYDL28GTImqalAya377lYtgASllHhGfe6q
        2/TjVbbdpbM03dfPIhTxGYh89o5n5w==
X-Google-Smtp-Source: ABdhPJzhJo64kJT3Sj2tCRef01F4L5IxDAbzuwCEDkm1GRBRbzYhoif+TuGiltccSnRWvZArs6aYVQ==
X-Received: by 2002:a9d:731a:: with SMTP id e26mr3164822otk.53.1604349417756;
        Mon, 02 Nov 2020 12:36:57 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z8sm3839151otm.45.2020.11.02.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:36:56 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        kuninori.morimoto.gx@renesas.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v3 0/3] dt-bindings: Convert graph bindings to json-schema
Date:   Mon,  2 Nov 2020 14:36:53 -0600
Message-Id: <20201102203656.220187-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sameer, I wanted to experiment with what the interface for graph users
looks like, so I've tweaked your patch a bit and converted 2 users.

This series converts the DT graph binding to a schema. Users of the graph
binding should reference the schema from 'ports' or 'port' node. Users
will still need to define what each port node is and any additional
properties that appear in port or endpoint nodes.

I'm still considering whether to apply graph.yaml to the dtschema repo
instead. Then I can sync adding it with a meta-schema update to check
for a reference.

Rob

Rob Herring (2):
  dt-bindings: usb-connector: Add reference to graph schema
  dt-bindings: panel: common: Add reference to graph schema

Sameer Pujar (1):
  dt-bindings: Convert graph bindings to json-schema

 .../bindings/connector/usb-connector.yaml     |  10 +-
 .../bindings/display/panel/panel-common.yaml  |   7 +-
 Documentation/devicetree/bindings/graph.txt   | 129 +-----------
 Documentation/devicetree/bindings/graph.yaml  | 199 ++++++++++++++++++
 4 files changed, 209 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/graph.yaml

--
2.25.1
