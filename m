Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2DB28E5BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgJNRxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJNRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:53:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FB3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:53:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q9so33329iow.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9VhKl5FefWluZOToOnttrb98bLhg6tznaGTvKOR1WyM=;
        b=LG38mpaEoTV3xmy9S+QxjaWHOFTAY40ftlyU0IYGVHB9VtZgunbOT4b7+0t1C5T/EG
         0K/xX3UGeFbtMaIaaUMcDJPwbrJa44CMtFBH7HQwj32Kb5q7UppzuMTRdu8z+SZYXjFA
         PJ4Hw8bx+hbBQN68dgzyNRS6WRMAmLQynrOhBd8bvU5I3WtPesoBslSTB3jYYGO6jWAl
         rCEMC7IdqsHuI0fO8ML8nHdP22EXBUYdmj5R0h6M66pECLDPcPY2EnMSdeQzFb/rXPE5
         XDkuRe2mxM4/p9Tvg2PunJju+QPcb8PtUcEjYhyJ3bsGJ+af/CgeLPyNFnul+AHDJEYb
         GDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9VhKl5FefWluZOToOnttrb98bLhg6tznaGTvKOR1WyM=;
        b=FhCZAf37PSI0IfxqoiM4DBWRs64qZonrX1jI4qzzKJ2q3VeMFzO9pmxFFl6npDwiG7
         d4uedxAodPy8ESJ5O1b4ccY4N+4cafAgxmgQcMTjx3/lJ2+F6zP4Gm4EcdFkYl9pDwaf
         9lln2504rdWai12QGp+ZnAFtyMmthOVCDOpW/nsuGZR9Y0wa4wW6v7q+iR70MQCdVSPc
         7NY6aaw3iR+GoYrQydwQR8z7cwwh0BhcOU8wu/GXi4FAWAqYeOZE/0gKKs27NhcE/Wuu
         QWqipq20NDmv7AvaLJxH0p17mkMlBvmXi24BpV//ltGoAMGaIb3O82MhszLeNFDsl1jR
         rDUg==
X-Gm-Message-State: AOAM531oqLQRiLlVs7gq4l3wMQLvDtwdzUwIiJULnjCSxi9HzUFL62WX
        r43CMC8EwsgBWT0N9npnyAI=
X-Google-Smtp-Source: ABdhPJw39voKKffSwqBpceAiKDbV1Rgd5kVKGzEV/A5CvZiPsXSMIKxOhx3sM5EaQ4yg9t4Akr+CZw==
X-Received: by 2002:a6b:144e:: with SMTP id 75mr422228iou.39.1602698032271;
        Wed, 14 Oct 2020 10:53:52 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
        by smtp.gmail.com with ESMTPSA id v15sm67765ile.37.2020.10.14.10.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 10:53:51 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Cc:     Jason Andryuk <jandryuk@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Remove Xen PVH dependency on PCI
Date:   Wed, 14 Oct 2020 13:53:39 -0400
Message-Id: <20201014175342.152712-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Xen PVH domain doesn't have a PCI bus or devices, so it doesn't need
PCI support built in.  Currently, XEN_PVH depends on XEN_PVHVM which
depends on PCI.

The first patch introduces XEN_PVHVM_GUEST as a toplevel item and
changes XEN_PVHVM to a hidden variable.  This allows XEN_PVH to depend
on XEN_PVHVM without PCI while XEN_PVHVM_GUEST depends on PCI.

The second patch moves XEN_512GB to clean up the option nesting.

Jason Andryuk (2):
  xen: Remove Xen PVH/PVHVM dependency on PCI
  xen: Kconfig: nest Xen guest options

 arch/x86/xen/Kconfig | 38 ++++++++++++++++++++++----------------
 drivers/xen/Makefile |  2 +-
 2 files changed, 23 insertions(+), 17 deletions(-)

-- 
2.26.2

