Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD728296695
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 23:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898217AbgJVVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505826AbgJVVY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:24:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CCEC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 14:24:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j7so1795194pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=m548N/pUewjuO1woINgGJ0CoX/HtQ1+ByYsCYcMLVKE=;
        b=LQoeTVJ4ze4ERYkUhHEVrpI8frOH/KnCH5FKMM16B83R5skUGI9qt2F6Mxf1lev5w2
         9bLNVPj8Yt7IiRNm4LeqFI37SYNaOLfyYMkhdxUI0EutKjjVIx2hi5ToCVrOX7A/dzYU
         bgXE64yG/qhIpeWT80V3liAXjf2ahD/rkwbYJOl+xCzmk7cgABRAgKCATg2vMJFUplym
         N/xJ8vrq0RvT+0eu+Sr6ssgBc31/T9nEXQkZj0pwAG3fcNWX5f49ulTHi5mocBbl1Rxp
         rq08GhLXx98JL/UoK8Sg2LcoGc3zpdrQRjwEJfNEKM0YvfKEa6rXzzaCeRk1HmTT67mn
         9DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=m548N/pUewjuO1woINgGJ0CoX/HtQ1+ByYsCYcMLVKE=;
        b=o5LHWn6ewRpmQaHYijkPzt2eIgiRm2zyEdtooYqddFmGzIFtzWS75RiDENFaAMciEp
         M4ggIevwFgpKcD827zMBZ488grzriBeaGjmSmmkVQFJY2zAGhIWlJwOqeH95BVyzStPy
         bo7hUbZEUMtM2yp8X3aYGhQTKdJpYZAgo6TKRb3Fznql5C/mQW468L1YXLRAv/AWe518
         w8v26ZuQZhrnsA+rpd9Y3Zjn8Mkaq0nvslzpY4qQmRrfRIljka9yCdPhOR0ZQzyBgQVR
         Odt5qKAf7E+H4ppEmTbReG1He4PtehQVfK7H8b8/YHPl3tTcviqYEl0CKKKgEurkIrlM
         6jDw==
X-Gm-Message-State: AOAM532vigiZMOqxzn/3ohyn3qeQerLO5EK8OP6ly2kBXOfsICFK297c
        k/IT2SIDXNqT5+E+jwOVo2TBIg==
X-Google-Smtp-Source: ABdhPJyhfBSC+52siau400RnxIzNfvIKY+gDyAevHbRM4Sbhr0RXoco4dCXwCXtmXfP+ggIs7yz0jA==
X-Received: by 2002:a17:90b:205:: with SMTP id fy5mr3416354pjb.34.1603401866628;
        Thu, 22 Oct 2020 14:24:26 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4a0f:cfff:fe66:e92e])
        by smtp.gmail.com with ESMTPSA id c203sm3188638pfb.96.2020.10.22.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 14:24:25 -0700 (PDT)
Date:   Thu, 22 Oct 2020 14:24:20 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@chromium.org, bleung@google.com, bleung@kernel.org,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com
Subject: [GIT PULL] chrome-platform changes for v5.10
Message-ID: <20201022212420.GA3714143@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.10

for you to fetch changes up to 3e98fd6d816cd82f529345870efd435f06e02803:

  ARM: dts: cros-ec-keyboard: Add alternate keymap for KEY_LEFTMETA (2020-1=
0-01 18:33:01 +0200)

----------------------------------------------------------------
chrome platform changes for 5.10

cros-ec:
* Error code cleanup across cros-ec by Guenter.
* Remove cros_ec_cmd_xfer in favor of cros_ec_cmd_xfer_status.

cros_ec_typec:
* Landed initial USB4 support in typec connector class driver for cros_ec.
* Role switch bugfix on disconnect, and reordering configuration steps.

cros_ec_lightbar:
* Fix buffer outsize and result for get_lightbar_version.

misc:
* Remove config MFD_CROS_EC, now that transition from MFD is complete.
* Enable KEY_LEFTMETA in new location on arm based cros-ec-keyboard keymap.

----------------------------------------------------------------
Azhar Shaikh (3):
      platform/chrome: cros_ec_typec: Send enum values to usb_role_switch_s=
et_role()
      platform/chrome: cros_ec_typec: Avoid setting usb role twice during d=
isconnect
      platform/chrome: cros_ec_typec: Re-order connector configuration steps

Enric Balletbo i Serra (1):
      platform/chrome: Kconfig: Remove the transitional MFD_CROS_EC config

Guenter Roeck (7):
      iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
      cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
      platform/chrome: cros_ec_sysfs: Report range of error codes from EC
      pwm: cros-ec: Accept more error codes from cros_ec_cmd_xfer_status
      platform/input: cros_ec: Replace -ENOTSUPP with -ENOPROTOOPT
      platform/chrome: cros_ec_proto: Convert EC error codes to Linux error=
 codes
      pwm: cros-ec: Simplify EC error handling

Gwendal Grignou (2):
      platform/chrome: cros_ec_trace: Add fields to command traces
      platform/chrome: cros_ec_lightbar: Reduce ligthbar get version command

Heikki Krogerus (1):
      platform/chrome: cros_ec_typec: USB4 support

Prashant Malani (2):
      platform/chrome: cros_ec_proto: Update cros_ec_cmd_xfer() call-sites
      platform/chrome: cros_ec_proto: Drop cros_ec_cmd_xfer()

Stephen Boyd (1):
      ARM: dts: cros-ec-keyboard: Add alternate keymap for KEY_LEFTMETA

Wang Qing (1):
      platform/chrome: Use kobj_to_dev() instead of container_of()

 arch/arm/boot/dts/cros-ec-keyboard.dtsi            |   1 +
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   2 +-
 drivers/input/keyboard/cros_ec_keyb.c              |   2 +-
 drivers/platform/chrome/Kconfig                    |  10 --
 drivers/platform/chrome/cros_ec_lightbar.c         |  12 +--
 drivers/platform/chrome/cros_ec_proto.c            | 106 +++++++++++------=
----
 drivers/platform/chrome/cros_ec_sysfs.c            |  26 ++---
 drivers/platform/chrome/cros_ec_trace.h            |  27 ++++--
 drivers/platform/chrome/cros_ec_typec.c            |  42 +++++++-
 drivers/platform/chrome/cros_ec_vbc.c              |   4 +-
 drivers/pwm/pwm-cros-ec.c                          |  37 ++++---
 11 files changed, 154 insertions(+), 115 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX5H4hAAKCRBzbaomhzOw
wiM0AP9Tu4HVIlp3UzG15gZYTyPUV16Jeq32ccfd9PVYczf7pgEA1k+M8yH3QJp2
wyhhRBgn9yMl8ap051EyqELLKJyEpAQ=
=tHBB
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
