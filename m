Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07926CA29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgIPTtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:49:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20479 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727725AbgIPTsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600285660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tkD7fLHRzfBDrWOBVG4rZwkIcJdSt6QPk/vTM/imCo=;
        b=B7ScFEvc0CFcGbEKO5hcfX4pTa7DwKn1/4fUcXiDCW65R2VyO9KtLB6guJV++aE01vSi7A
        nktvbqXxz2awlmJxdlJ5umlC71tOEVSW+a8kItsVcC+KiEnC+jhvh89S3Snqsw5webjNwB
        F6o6YrKts+k0JoklOaYsl4DoaB4hVpE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-JfhrSMTTM2GhLAxcZpJFiw-1; Wed, 16 Sep 2020 15:47:39 -0400
X-MC-Unique: JfhrSMTTM2GhLAxcZpJFiw-1
Received: by mail-qk1-f199.google.com with SMTP id 205so7097191qkd.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9tkD7fLHRzfBDrWOBVG4rZwkIcJdSt6QPk/vTM/imCo=;
        b=swCMgXHedx0mCqfN8zT1/oRpuMylQaIbCZchz2IV4C9jkIHoIcd9iJGKUMUXp+ktDg
         +56VKQNc7mcElL3f8awHCuiyxpeOm+Y7RON49eetalDHQ1THtC2kXYKkckowBznSaDGD
         2DjHjIXHIiIvJBFz7bfOvcFStSaRGnCi8lqHgBq5ubRIvfVsrmGJO2AkRzXtjex2cJui
         gvAl/9NweD1Vb/nXtoi3e7qVy4mzGdjVRjBqbxQSQmGEuSPCW6wPRItILTygG0TcqIzB
         TkWns3eWhW2fcwH22jcH15aZUz0Z2FHOEsyGhccVvRRfo8fD2Aj7Afz2/mdwmnXKEgRY
         IgNw==
X-Gm-Message-State: AOAM531qAmtuDGaAwdnCUBxDwWZ0yyUI5zPC0pvcxiOSFu5d1NmRJM34
        Y0DmUCmjCUY7UXdpObljsYk1vZsrecppvoB7g3S3PVXgh+fT4IpJXdSqQ7EHwcN5QA1d+cXv4zi
        wS6MKise5S1joFNp5xbLR1jzx
X-Received: by 2002:a37:a514:: with SMTP id o20mr23551147qke.374.1600285658948;
        Wed, 16 Sep 2020 12:47:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxq3px1MuOCLEAZ17g8N7rutkh9QqWBZHPIaoMca4ZxTzOIagFtyp9Bsgm4Yt1jLSoR/n1gQ==
X-Received: by 2002:a37:a514:: with SMTP id o20mr23551136qke.374.1600285658700;
        Wed, 16 Sep 2020 12:47:38 -0700 (PDT)
Received: from dev.jcline.org.com ([136.56.20.95])
        by smtp.gmail.com with ESMTPSA id g4sm18683447qth.30.2020.09.16.12.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:47:37 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH v2 0/2] Add fine-grain temperature reporting
Date:   Wed, 16 Sep 2020 15:47:09 -0400
Message-Id: <20200916194711.999602-1-jcline@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200812204952.1921587-1-jcline@redhat.com>
References: <20200812204952.1921587-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series adjusts the temp_get() interface in the thermal functions to
report milli-degrees, and additionally alters the way errors are
reported. As I went through all the users and implementations I realized
that Pascal's temp_get() implementation didn't include turning negative
temperatures to 0 like other implementations, so I separated error
reporting from the temperature in the API.

Couple of things I'm on the fence about here:

* I allowed the nvkm_therm_temp_get() functions to accept NULL as a way
  to check if temperature reading is available rather than adding a
  separate helper, but was torn about whether this is clearer than a
  separate helper function.

* I added a WARN_ON in places that previously called
  nvkm_therm_temp_get() and didn't check the return value for an error.
  This may not be a reasonable error handling method.

Jeremy Cline (2):
  drm/nouveau: return temperatures in temp_get() via parameter
  drm/nouveau: Add fine-grain temperature reporting

 .../nouveau/include/nvkm/subdev/bios/therm.h  | 13 +++++++++
 .../drm/nouveau/include/nvkm/subdev/therm.h   | 28 ++++++++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_hwmon.c       | 12 ++++----
 .../gpu/drm/nouveau/nvkm/subdev/therm/base.c  | 28 +++++++++++++++----
 .../gpu/drm/nouveau/nvkm/subdev/therm/g84.c   | 11 ++++----
 .../gpu/drm/nouveau/nvkm/subdev/therm/gp100.c | 11 ++++----
 .../gpu/drm/nouveau/nvkm/subdev/therm/nv40.c  |  9 ++----
 .../gpu/drm/nouveau/nvkm/subdev/therm/nv50.c  |  9 ++----
 .../gpu/drm/nouveau/nvkm/subdev/therm/priv.h  | 17 +++++++++--
 .../gpu/drm/nouveau/nvkm/subdev/therm/temp.c  | 12 +++++---
 10 files changed, 110 insertions(+), 40 deletions(-)

-- 
2.26.2

