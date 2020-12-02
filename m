Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29C2CB727
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbgLBI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgLBI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:28:00 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-sgx@vger.kernel.org, x86@kernel.org,
        xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH 0/2] Fix some kernel-doc markups with wrong identifiers
Date:   Wed,  2 Dec 2020 09:27:13 +0100
Message-Id: <cover.1606897462.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After applying this patch over next-20201201:

   https://lore.kernel.org/linux-doc/cover.1606823973.git.mchehab+huawei@kernel.org/T/#m0072adc6eb1af595a31fcc3b019cb81ab28c7b9f

There are a couple of new warnings that the kernel-doc prototype
doesn't match the documented function.

This series address them.

Mauro Carvalho Chehab (2):
  asm: sgx.h: fix a typo on a kernel-doc markup
  drm: amdgpu: fix a kernel-doc markup

 arch/x86/include/uapi/asm/sgx.h            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.28.0


