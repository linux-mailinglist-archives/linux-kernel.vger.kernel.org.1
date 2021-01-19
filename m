Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3F2FB732
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbhASKa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389750AbhASKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:15:43 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657D3C061786
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:12:31 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b206so19705333qkc.14
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NjVlArdIN6XBREuMLmty8CemszohTwcOxRUNv6vk0tE=;
        b=UAANM1vPEyK7nnN0KCnU2dCdvDX9ddj2cmxwwLimZZVKPH+auhlB6cTX3b92qgNccC
         Th5o/ePELfILePjL9zfdtbv2tjholwMLzpIv2nwRVPWegVEHowxWP4ZZxmLcw1HntgSg
         n++/Vk9KHT26SpvMeB4DrZ9/XT9UruIMjn2/FqWWhP2Vc73WZr1rroDsQWp+GbDRpRt+
         qQY0RPbIhGSLyLjmhGditDJvEh3j6TuU8GFOMCAeGA5ReTOLKvOfyF/dYjH+Qy4Tx65s
         wRWNgGWuhtRBeYTyVGZty2tw08bvF8suqoMYj+2sr4noSJ3WXwGSo1A2WbcavUDE2xTa
         WYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NjVlArdIN6XBREuMLmty8CemszohTwcOxRUNv6vk0tE=;
        b=TvB/DjVQM54R0lV6i0dNm6sX+intumDqlFqpOSMyV7xVYgtAudag7xI/a3MiWo6wnS
         Fl4+2ko3866cQ/h976TYjh5i5fcuwTh9uW/ezIww0aZ2y4/yZV2CNo2JBNavA6xGv7UC
         IfUuVf/J/ElIasSIyTKdzMnQRcPcTP3NXHQUH9LCXpDAXBM97/usc594HIOn+HHyF/Yi
         iEMLYf/QPQ7S6LlG6sQgrJOaVZsPh74csa4rJLXSpoxPupe7WgjoBo6xaQyMudT8I7Wj
         OBJ4e2gDwEjmzgUdkKEtAjR/stgqZlUmjUmyGoVWgTCr2aD7JlvDG6pvxou6aqKVoa/8
         ExrA==
X-Gm-Message-State: AOAM533sUG640USEb8HYCIBzMTc0Lb+nmSrwxw4GY78dIxt0WRmAspie
        +fFwTdNG6PL19PaivkP2gcsw75FitwkixGk=
X-Google-Smtp-Source: ABdhPJzKmB2mfsO4Dgp4lThaRebuuK4DObPDnyCOuCOnRLulqfaZapr8g6IraFi2N/rrIFpFg8uebolojyene2A=
Sender: "howardyen via sendgmr" <howardyen@howardyen.ntc.corp.google.com>
X-Received: from howardyen.ntc.corp.google.com ([2401:fa00:fc:202:5d06:ba6f:6a89:a201])
 (user=howardyen job=sendgmr) by 2002:ad4:49cd:: with SMTP id
 j13mr3666683qvy.5.1611051150583; Tue, 19 Jan 2021 02:12:30 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:10:44 +0800
In-Reply-To: <20210119101044.1637023-1-howardyen@google.com>
Message-Id: <20210119101044.1637023-5-howardyen@google.com>
Mime-Version: 1.0
References: <20210119101044.1637023-1-howardyen@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 4/4] dt-bindings: usb: usb-xhci: add USB offload support
From:   Howard Yen <howardyen@google.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document USB offload support for usb-xhci.

For example:

&usbdrd_dwc3 {
	...
	/* support usb offloading, 0: disabled, 1: audio */
	offload = <1>;
	...
};

Signed-off-by: Howard Yen <howardyen@google.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index b120dd6612a2..aab1fd499f15 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -46,6 +46,7 @@ Optional properties:
   - quirk-broken-port-ped: set if the controller has broken port disable mechanism
   - imod-interval-ns: default interrupt moderation interval is 5000ns
   - phys : see usb-hcd.yaml in the current directory
+  - offload: supporting USB offload feature, 0: disabled, 1: audio
 
 additionally the properties from usb-hcd.yaml (in the current directory) are
 supported.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

