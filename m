Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B66300780
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbhAVPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728769AbhAVPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611329762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5OaetzA2X1k5MGEpKaxVndnYKGJLfNEC7k1ws4H5Z8k=;
        b=iIg/XyWUFcJhdv5FsXs88QTRBusCAsJoVS/MNuaOn0z5ycUF93Cl6kkWG/HWi4jthaHRnP
        ws5sR0AEQdpRXpTArVjAEp5mi54Jvecn9p6WfrGz3nJy1Tjb19lNYF5T6QKu/xg8iuzhVw
        P1hjpT1dNn49wHhDJXAMui1alOeCuyg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-VfpjBmwROiuYRnAOu9v0QQ-1; Fri, 22 Jan 2021 10:36:00 -0500
X-MC-Unique: VfpjBmwROiuYRnAOu9v0QQ-1
Received: by mail-qv1-f70.google.com with SMTP id m1so4073351qvp.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OaetzA2X1k5MGEpKaxVndnYKGJLfNEC7k1ws4H5Z8k=;
        b=NdjFuZGIPAqA+7w5s/mjTLXIu5VCC6vdpaGFJqZGcwZxczbfsgr8aGy0fuuEOUlTYy
         dHDIv5dGnlL8EwFCnt0FYetTW/c+4mSdI4r4Th8W+9hk1iQi1UmpeLJIM/tS/d/QspkJ
         pkTKt/nhl5/Cs9iHAjkopT6rTGHxZ18WLUzHnuege91/Tw6GbdxyQRtI7BTvYjTTgGTM
         tNPCNtjnfV4Xx78fxx8RNgS2SvDlXOi68HpKdUyQy0RuHv6ZUOc/NPAX8aISZZnDpCP2
         flYglcOOyJi65KvlOAe5QRKetzn/4dCftEuXReTSTBIKIlqNorXNwyaP6OPWONW6WSXX
         w1bw==
X-Gm-Message-State: AOAM530AFsVnddu1SF1CCpE4UMsge+qGhIH2/Co7uRGSfe4/0dI/IdQk
        PH/EcyD23NYXBZEeK5J9C+8T5+gxityU1RYMBdHvxYC5CKkaRqf/IPbnpqn5OXGUCo2++pFLcjx
        VAJ2tidhZhBnDgk/lcf44BAKxb05zeweKdK88mtpjAM+qnZXE9M/p6Nw1WN3/JYXaFRzqCEY=
X-Received: by 2002:ac8:742:: with SMTP id k2mr1262085qth.46.1611329758892;
        Fri, 22 Jan 2021 07:35:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy++Z+hJclHXyI3osvFTQcObz6LvEA4A4Z9JXbk6AQZM6ZRtWQeFFTZvLsnyyLEFv/Dj5ZLfA==
X-Received: by 2002:ac8:742:: with SMTP id k2mr1262060qth.46.1611329758646;
        Fri, 22 Jan 2021 07:35:58 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t51sm1309069qte.8.2021.01.22.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 07:35:58 -0800 (PST)
From:   trix@redhat.com
To:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: Add FPGA SUBDEVICES
Date:   Fri, 22 Jan 2021 07:35:52 -0800
Message-Id: <20210122153552.1606152-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Every FPGA has several subdevices in other subsystems.
The new FPGA subdevices section is necessary to ensure changes to
the subdevices files get reviewed within the context of the FPGA
subsystem.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17ac5bdce521..cdda41f182b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6975,6 +6975,12 @@ F:	drivers/fpga/
 F:	include/linux/fpga/
 F:	tools/testing/selftests/drivers/fpga/
 
+FPGA SUBDEVICES
+R:	Tom Rix <trix@redhat.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
+F:	include/linux/mfd/intel-m10-bmc.*
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
-- 
2.27.0

