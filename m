Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865BC29F5BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgJ2UA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgJ2T7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:59:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A9C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:59:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i26so3235047pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rL9uxiAdfucO8UO5FHQujK/Xm1zR5LWMQc64OMNsK4Q=;
        b=R7mcWd2/M1pindEBIFka/eqKuPGxSCfiSyZLT+Hop4mrgif01boVkOaDZ5K5WZuc4V
         sNS20oOs2/91ajEU6GL8BiFUVQMDQ4qJUsbp/5mGnfi0x8vtkIH4bxVEjIAv3XDbaP9y
         GHZbe4XAM9F+/lYqMercXTldY9i4nbqbvpfC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rL9uxiAdfucO8UO5FHQujK/Xm1zR5LWMQc64OMNsK4Q=;
        b=pwZy3zEodLZ8peRn7/xmtFZ+z8ydMS/oqiGniakvkk1FdsNcRf/k/hEItcKFfbUa8l
         8Q8K9XQ8V/Pi4PblEJV4sP+RXmFghOv9RFbaRMrheHDVI7lvoggGeVwN4UITCot1/9Ck
         ATMbuqPJSDOq+Tpu7/UxX5R1TQY/Mn8wWRkVdA5aaVPNMPjQfdrJi/pmZ6aqEM2LVFYu
         8OQAgf3yyyhbKYnSVx6r8lkx1/aK7ID5BlSzAvGEIF/2lGPZLMhZie9IBKqhscpvGYzj
         XrfrZMLxbmyl1PxZk6Dd0xwfsT7c3fIzZAyZCCCr+kWpnqW38sazdgCxiAQ1l1JxVF5X
         TGLA==
X-Gm-Message-State: AOAM532zb0D0PRjhXQea1vTKQyh30rol+wPrezwR65cQ7OI4FUDTKFUc
        z/t/vHAZLrnpP3c3RGEdPMoUxQ==
X-Google-Smtp-Source: ABdhPJxz2N0u0/tltHLgA1X64eG9KuDR0ZyM23oM1HLPpFPG1XwaXwPsA8QXoEfpETWwVl2lNCWirw==
X-Received: by 2002:a62:7a8d:0:b029:160:9e0:5ff6 with SMTP id v135-20020a627a8d0000b029016009e05ff6mr6118429pfc.52.1604001563991;
        Thu, 29 Oct 2020 12:59:23 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z27sm3682662pfr.206.2020.10.29.12.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 12:59:23 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     sudeep.holla@arm.com, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/2] mailbox: Add Broadcom STB mailbox driver for SCMI
Date:   Thu, 29 Oct 2020 15:59:05 -0400
Message-Id: <20201029195913.5927-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000075ad0c05b2d4b7bf"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000075ad0c05b2d4b7bf

Patchset Summary:
  Adds a simple mailbox driver for the use of the ARM SCMI drivers.

v4:
  Commit "mailbox: Add Broadcom STB mailbox driver"
  -- Fixed indentation on Kconfig file (again, RandyD).
  -- Removed superfluous #ifdefs for ARM/ARM64 (RandyD).
  -- Fixed Copyright year on source file (RandyD).

v3:
  Commit "mailbox: Add Broadcom STB mailbox driver"
  -- Fixed indentation on Kconfig file (RandyD).

v2:
  Commit "mailbox: Add Broadcom STB mailbox driver"
  -- Remove the Kconfig dependency on SMP (Florian)
  Commit "mailbox: Add Broadcom STB mailbox driver"
  -- Drop label,unit address; changed title,description (RobH)

v1:
  -- Original submission.

Jim Quinlan (2):
  dt-bindings: Add bindings for BrcmSTB SCMI mailbox driver
  mailbox: Add Broadcom STB mailbox driver

 .../bindings/mailbox/brcm,brcmstb-mbox.yaml   |  39 ++++
 drivers/mailbox/Kconfig                       |  12 ++
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/brcmstb-mailbox.c             | 167 ++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,brcmstb-mbox.yaml
 create mode 100644 drivers/mailbox/brcmstb-mailbox.c

-- 
2.17.1


--00000000000075ad0c05b2d4b7bf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJIei25JWQZX
+cJ2QG0waZGrY6v9R+jklcCO+AF9Fp95MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTAyOTE5NTkyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCa9Nadp1jfkWw1saIOfVYZyTla7wj7
fPQ+v3x/bnpRtmenXPMJRUKN/AUyj+M2EgfOKXh95ZRF5j68Q0mBQH5f8wf7NCL+VwYFPw5rSEp7
m52dr8lruH7qOtUMD7ExAgeGmkZNAgILSV8PLiv+JXY+rys6g3fdUy90BP9p8wyhR6uP6HCMOuJd
MsjBRF4wUhzUHlHbZuwjTwDXB0uQ6cj2rSKin7oZwDPcVvkhNT8VYHFU7WA4iJpo6Xxjp4t2W4VT
yCeS5L8ND55V1xEVvNaklqH4tdmw1IWqA3dULCgbF2E8vnGwQDlVvUjbdchZnfxRrZ2uG21yAZ6L
V5pyFSwq
--00000000000075ad0c05b2d4b7bf--
