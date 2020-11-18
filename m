Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268F42B8049
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgKRPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKRPU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:20:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A12C0613D4;
        Wed, 18 Nov 2020 07:20:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l5so2366677edq.11;
        Wed, 18 Nov 2020 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JdBpN+/s+eu4dMv9PKV8l+WsBUdr8tnMkExlePSrDm8=;
        b=Pk48p8ZtWUvC6e3UkkoxM7aqSmvdiN2K0VPViD+hEhTP5zYx83Kp4XszdIG0mxNWL6
         YQyOYsa3TDm5hgynlL7ZrA0YeKr1tbpq8dNSo4TfbJPHLe0TwD6bZBU7GT6S3WUiJmJC
         oVhbzrsBb+cMHMmMubgpmzj5P19FBqbqurmXtwDzEDWit0tSFS/UOHE80i1SAM4CFn7e
         ivRYGc+P9oJ7MiacCZAJN+RGQPKCXptvtvLVQlsI1Iju6BQQ0eQVq+EpiS84sjhqOTis
         n0QAxuUbEuXUtTYQ15EQ573E53OY11o4EFofeljWJNRHIElT0rWaES6Mc7vOh8eTdMet
         biWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JdBpN+/s+eu4dMv9PKV8l+WsBUdr8tnMkExlePSrDm8=;
        b=qEGEspwMFv+FlaAsRSZE84XD4Py7WHMI4FHoOOFq/JNYd/q7H5yhOw6dElZswecSkK
         +ySr3lJ+ZHjx41yqhzLIgOgD8vyRf1L8fyZw6AM7Cp5i2SOen78cGduO+UfiDFeaHnyi
         8zqSvZWrSsR6v5Prt36dEqvGCXxtSvJmTInteTW9m9b/WFfR8Kb/yTA6O9MjIGG1C7Lt
         YgF+8eoa4f8E3ohSuuJwIfZ14zwyzdt+PQJ9+0DHfkvM3QvL4nxwkroRKqtPDIglO03T
         kYLxhaHV4Gb1C1uXNMytQhiKTAd47YG6OeH9MkWmCOISOznseJZiXfJ9iLfOlCu7+cAd
         F/9A==
X-Gm-Message-State: AOAM530KvUZy821saTiClOvn1x9Mw9YbBytWqUB2XoTDEr4XAwDaDr0J
        zJ/Ia42JEzl5Yh0e48bMUjA=
X-Google-Smtp-Source: ABdhPJy/MblYFWTmZbo0aQQjxf6nUrrToTAbkYlP+jLasvfvJ5DUvNMQ3reeUa6qQ5jMzJUSxniU4w==
X-Received: by 2002:aa7:c5c7:: with SMTP id h7mr2366534eds.143.1605712853164;
        Wed, 18 Nov 2020 07:20:53 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id k3sm12554313ejd.36.2020.11.18.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 07:20:52 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: Fix error in 'make dtbs_check' when using DT_SCHEMA_FILES
Date:   Wed, 18 Nov 2020 17:20:50 +0200
Message-Id: <2519b8bde507ca6ccea9765ea197adaaa69a66d5.1605712328.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DT_SCHEMA_FILES is specified and contains more than one file paths,
'make dtbs_check' fails with the following message:

  $ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml path/to/schema2.yaml"
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  Documentation/devicetree/bindings/Makefile:77: recipe for target 'Documentation/devicetree/bindings/processed-schema.json' failed
  make[1]: *** [Documentation/devicetree/bindings/processed-schema.json] Error 255
  make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.json'
  Makefile:1364: recipe for target 'dt_binding_check' failed
  make: *** [dt_binding_check] Error 2

The error code 255 is returned by 'dt-mk-schema' when invoked as
'dt-mk-schema -j -u @<tmp-file>', where '<tmp-file>' is a temporary
file that is generated to contain a list of SPACE delimited schema
file paths, as indicated via DT_SCHEMA_FILES.

However, it seems the file format has been recently changed in
'dt-mk-schema', which now expects each schema path to be provided on
a separate line:

 $ dt-mk-schema --version
 2020.12.dev4+g6de1c45

Therefore, let's change '<tmp-file>' content format from

 path/to/schema1.yaml path/to/schema2.yaml ... path/to/schemaN.yaml

to

 path/to/schema1.yaml
 path/to/schema2.yaml
 ...
 path/to/schemaN.yaml

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index f50420099a55..643eb873fd51 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -37,7 +37,7 @@ quiet_cmd_chk_bindings = CHKDT   $@
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
                       $(if $(DT_MK_SCHEMA_FLAGS), \
-                           echo $(real-prereqs), \
+                           printf '%s\n' $(real-prereqs), \
                            $(find_cmd)) > $$f ; \
                       $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
 		      rm -f $$f
-- 
2.29.2

