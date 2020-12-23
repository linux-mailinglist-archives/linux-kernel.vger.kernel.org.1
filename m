Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172CD2E10CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 01:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLWAaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 19:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLWAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 19:30:08 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFECC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:29:28 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id n10so9464049pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=l97S5Z/QIULJCQWu6XLTipKuSnTnmr3lQujC42RhJrU=;
        b=Z1xTkspcd+1JzZ8IrPdqa/n1ZULJW26viXerheU9s4nud5D1odZuji0EfrM8R3pgtl
         BCiYCqpVYCGTTAtJOAmOWMk22LUOTAO0HXhmWpQdgYVE4fen+/SaI1CCb80BCsj8brDr
         s014cBriWbsJBb7K/OI56uFuOzqynEeAdlAr73HHOOWh34V64NcmZzdrb4Vwj+StpzyC
         hI0akG2C212S/9sGYctgl1JxKQXH0YYGWLn3SBt+fgCjmjBzNXG6b+7RfRKblftCPtoe
         hMzGE/C0GO5HuqHZfWglZitsBrdA4fnyOxK0hNgLuSl+PpLSZB6vPDEhYFMjCAXPWqfm
         zPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=l97S5Z/QIULJCQWu6XLTipKuSnTnmr3lQujC42RhJrU=;
        b=Cjti1KU3+faPMrC4KLS55cs/ZdtE/n4UHXNApqpHRBq368vHbvE6FnZn5bL7VlrJOA
         PPJVwGq0GqKkkjVtMGHhRXrmzd1Uve1b+VeS9D5YNugLPWy5po3xSkbdjtODFJ6sajy9
         RrY2HNjhzGIp4hvsqkapsNppVHL50lTj6A7ovE93aXCjvpyDFt2kSZMQzF2ThMIt4cJt
         ip61naPqKmIDfgBSqBtEv3Ap0aQguWAn3/1RH+NcmbSesGv2xmlTbd3fD4cc1nge6VEL
         fXbqLP52LvqMpJJ9FhGsCU2iFg0fUhVcduGs+2wABXlRCB3av9cSk1dgmNHRVxzB4p+C
         G85w==
X-Gm-Message-State: AOAM530ZhclPdrwW7roOCt5PSfqXXCaoz1KKgsL+EqQ3itRFDCl4j2KA
        /8Cna64OvuOfYZnd3HQ/Bg44GQ==
X-Google-Smtp-Source: ABdhPJxuM6WYWWvuc5TdCxogx3rZ7P7FRpM/ckhH6GQ0bIRuzcFQQv7T7yuwjOgYtrfbAwZovjIiEA==
X-Received: by 2002:a62:17d0:0:b029:19e:5cf9:a7f6 with SMTP id 199-20020a6217d00000b029019e5cf9a7f6mr21862451pfx.0.1608683367245;
        Tue, 22 Dec 2020 16:29:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id t23sm22022466pfc.0.2020.12.22.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 16:29:26 -0800 (PST)
Date:   Tue, 22 Dec 2020 16:29:21 -0800
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        bleung@google.com, bleung@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.11
Message-ID: <X+KPYZIAZXFOI/YD@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ZdnS686BPgsb+2H"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ZdnS686BPgsb+2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.11

for you to fetch changes up to 6ae9b5ffcaeba64c290dfb8bd7b0194b1fdf0c92:

  platform/chrome: cros_ec_typec: Tolerate unrecognized mux flags (2020-12-=
10 13:05:16 -0800)

----------------------------------------------------------------
chrome platform changes for 5.11

cros_ec_typec:
* A series from Prashant for Type-C to implement TYPEC_STATUS, parsing USB =
PD
  Partner ID VDOs, and registering partner altmodes.

cros_ec misc:
* Don't treat RTC events as wakeup sources in cros_ec_proto

----------------------------------------------------------------
Prashant Malani (8):
      platform/chrome: cros_ec_typec: Relocate set_port_params_v*() functio=
ns
      platform/chrome: cros_ec_typec: Fix remove partner logic
      platform/chrome: cros_ec_typec: Clear partner identity on device remo=
val
      platform/chrome: cros_ec: Import Type C host commands
      platform/chrome: cros_ec_typec: Introduce TYPEC_STATUS
      platform/chrome: cros_ec_typec: Parse partner PD ID VDOs
      platform/chrome: cros_ec_typec: Register partner altmodes
      platform/chrome: cros_ec_typec: Tolerate unrecognized mux flags

Stephen Boyd (1):
      platform/chrome: Don't treat RTC events as wakeup sources

 drivers/platform/chrome/cros_ec_proto.c        |  14 +-
 drivers/platform/chrome/cros_ec_typec.c        | 336 +++++++++++++++++++--=
----
 include/linux/platform_data/cros_ec_commands.h | 155 ++++++++++++
 3 files changed, 427 insertions(+), 78 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--3ZdnS686BPgsb+2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX+KPYQAKCRBzbaomhzOw
wouSAP0fqnugNRf4q0cFqgJiZ6aq2Zvqu8MRUj/IcZuUOzf5bwEAtWCqNA0Y+bbm
xe5J91+uNYRgGRFGxXBardXBGr/96Ac=
=BuFD
-----END PGP SIGNATURE-----

--3ZdnS686BPgsb+2H--
