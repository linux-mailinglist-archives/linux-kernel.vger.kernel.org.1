Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2341E99F9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgEaS4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgEaS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:56:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355DAC061A0E;
        Sun, 31 May 2020 11:56:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e2so7121672eje.13;
        Sun, 31 May 2020 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RNkHOML5FF6ZSQOlglHi4/y91XOJKfFGnpUO92kIJ3s=;
        b=sImQZ3WaB/mkAFxMWPpLDhstWwqBTdv8739g/NGUaH/ioC1U4TYWIYCw+reUIV+1Wu
         SNe12MJn0dJmPE01u78oaodV31e4FO9oB8pVNsRhpUrl3Mp90mrfNSHg0CTGKWPsrKxR
         K7oiA+ZbYIpF7rVi6kR7cZI/rjIWq8W8fVIfm2feP2yGr64ceLsscz4z+qe0TsmwDt25
         XzK6X/LaKeuM66ZkM5u87MaVSrG1kk+pLaeyNcAttKEljJAapHviH6aVKS0qZV659aKM
         2sBrfV3/9DY7Lnr4XeCBfrbhwmCYieDcAl3sPijHNdcVuTea5T8MtHSNPicoSjaMdKty
         cs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RNkHOML5FF6ZSQOlglHi4/y91XOJKfFGnpUO92kIJ3s=;
        b=AMYi4iAJUzUz5VVntGt/1p+uRNLd/Q8BAWt6llgwMkxy6tYiarrAtpqraLNLVP5Xgk
         DD/pb/EAEOvFy+MWTVyHNx7v5ANq5VJ83Z5+uK6OZ5SRQwWyUnWLjShdScbEFh06/wQy
         GU/pRUC7cCEWT1KJj0hcLni9IbDTIcx30uUYKwCgElr2a44DzorcJo4WAU9GpCqmVhiW
         E/+yQ5NKrY7RIbcjqtlwVNhWo75QrBEGZzUdFwc1rLdTQn3rwi4tUFz2BTmClO+XETiG
         gO60tCRUSOM6HfGbpOqZ3fLPLdI/SmxVyLMF+o5H9pafZ7O+dK20qB2omgqpMrgNGvp2
         CJBQ==
X-Gm-Message-State: AOAM530WVEiIWUM37rGjD0ZLa1RhfM1wtj2RcuQBKcZvR7sho5v7c8Km
        HP4W2M4pHVRmYUtUAd23fA8=
X-Google-Smtp-Source: ABdhPJxshDs2+5ehML4fKmCm+E/WaZ0Mrq96yPJH3lODHE+UUHZviLOdGxt5O/fRHCAim16EV//z+Q==
X-Received: by 2002:a17:906:e211:: with SMTP id gf17mr16702126ejb.495.1590951394643;
        Sun, 31 May 2020 11:56:34 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d2d:7800:bd95:ecb6:e9e3:ecd3])
        by smtp.gmail.com with ESMTPSA id w12sm13685736eds.4.2020.05.31.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 11:56:34 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: it_IT: address invalid reference warnings
Date:   Sun, 31 May 2020 20:56:18 +0200
Message-Id: <20200531185618.7099-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation generation warns:

  it_IT/kernel-hacking/hacking.rst:
    WARNING: unknown document: ../core-api/symbol/namespaces

  it_IT/process/5.Posting.rst:
    WARNING: undefined label: it_email_clients

  it_IT/process/submitting-patches.rst:
    WARNING: undefined label: it_email_clients

  it_IT/process/howto.rst:
     WARNING: undefined label: it_managementstyle

Refer to English documentation, as Italian translation does not exist,
and add labels for Italian process documents to resolve label references.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jonathan, please pick this quick fix of warnings.

applies on doc-next and next-20200529

 Documentation/translations/it_IT/kernel-hacking/hacking.rst   | 4 ++--
 Documentation/translations/it_IT/process/email-clients.rst    | 2 ++
 Documentation/translations/it_IT/process/management-style.rst | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index 6aab27a8d323..e9a2e92134f0 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -634,7 +634,7 @@ Definita in ``include/linux/export.h``
 
 Questa è una variate di `EXPORT_SYMBOL()` che permette di specificare uno
 spazio dei nomi. Lo spazio dei nomi è documentato in
-:doc:`../core-api/symbol-namespaces`
+:doc:`../../../core-api/symbol-namespaces`
 
 :c:func:`EXPORT_SYMBOL_NS_GPL()`
 --------------------------------
@@ -643,7 +643,7 @@ Definita in ``include/linux/export.h``
 
 Questa è una variate di `EXPORT_SYMBOL_GPL()` che permette di specificare uno
 spazio dei nomi. Lo spazio dei nomi è documentato in
-:doc:`../core-api/symbol-namespaces`
+:doc:`../../../core-api/symbol-namespaces`
 
 Procedure e convenzioni
 =======================
diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index 89abf6d325f2..66d3d65776f7 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -3,6 +3,8 @@
 :Original: :doc:`../../../process/email-clients`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
+.. _it_email_clients:
+
 Informazioni sui programmi di posta elettronica per Linux
 =========================================================
 
diff --git a/Documentation/translations/it_IT/process/management-style.rst b/Documentation/translations/it_IT/process/management-style.rst
index c709285138a7..76ed074082ea 100644
--- a/Documentation/translations/it_IT/process/management-style.rst
+++ b/Documentation/translations/it_IT/process/management-style.rst
@@ -3,6 +3,8 @@
 :Original: :doc:`../../../process/management-style`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
+.. _it_managementstyle:
+
 Il modello di gestione del kernel Linux
 =======================================
 
-- 
2.17.1

