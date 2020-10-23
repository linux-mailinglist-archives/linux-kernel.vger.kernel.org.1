Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4E9297722
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755053AbgJWSfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754827AbgJWSeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603478045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JBSwivOieEBkLj+y5xNLmYzl5BJ4oB5HgP2xMsJ50A=;
        b=HfWKhJIONs7XxKSYtZQnVZua3rEpLoz5V+GFqbAuAb8PRoR2GxTsriTyVyDHnsvRgCUPms
        jjecDM/HFkaEHntBLc0iMReJ86fTCRAh0ZSVNhVZf9el3P8y9I77BYCzVV5ozRUvMiyRnt
        Qad6oQLvBkahvmesrCIE4I3Oh9t0oW4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-G2OUbYPzOC60Kz8f-oHbbw-1; Fri, 23 Oct 2020 14:34:04 -0400
X-MC-Unique: G2OUbYPzOC60Kz8f-oHbbw-1
Received: by mail-qv1-f69.google.com with SMTP id l8so1572385qvz.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JBSwivOieEBkLj+y5xNLmYzl5BJ4oB5HgP2xMsJ50A=;
        b=exL6U6VKzTnBVPfD2JXQoN1XRJfvTidkeR+e37lUeEz/B/U3dWBrcFOf3bnXHTMALb
         tyhsIUBo+cUn/JQ/CBwctTtBQp6Y34lePIAV92ZK6yyobuEAR0tXM41vQxt1GCRs+N3+
         84mYdp6MvjwPI7OdQoecBqrOHEVsyjTeDZPzWXJ1omkveVl5Jrsg/DAzQN8XB+RD1Met
         L5EZR64TzyxyZHNpSAez6UJNhlMegpXG4ybHvWYEs4e1kzJ7YQMFiU3CNQ/6L27OR1d2
         RnbT02XXe6ftptATM/dk30o39S9kNuO/XTeDz3Bh6SNe8Uu5JKOdJIFD7StDh7bUXycj
         i38A==
X-Gm-Message-State: AOAM533aUKMSciJKPj54AiwMRdLaptCWzNLSvTaRopzbgBfp8xMXnZ6w
        4lnkGOtSEOPKhVqj6F1Uqi56TVWJaccblBD+unAHoDedfYYypy3/xJirQJ26SiwcDPLcLyRS/fm
        tgN9knkcCe/bcIlyQzD0YZaTO
X-Received: by 2002:ae9:f305:: with SMTP id p5mr3428231qkg.481.1603478043598;
        Fri, 23 Oct 2020 11:34:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyotm8QmAhrS0v/p7J+qOW64NCqV+9LILBDSp3tkCimtWR3nIRvM9TECufCj/QUX+Vhg4d9ZA==
X-Received: by 2002:ae9:f305:: with SMTP id p5mr3428213qkg.481.1603478043405;
        Fri, 23 Oct 2020 11:34:03 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id u11sm1490407qtk.61.2020.10.23.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:34:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Andrew Jones <drjones@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v15 02/14] KVM: Documentation: Update entry for KVM_CAP_ENFORCE_PV_CPUID
Date:   Fri, 23 Oct 2020 14:33:46 -0400
Message-Id: <20201023183358.50607-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023183358.50607-1-peterx@redhat.com>
References: <20201023183358.50607-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should be squashed into 66570e966dd9cb4f.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/virt/kvm/api.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 094e128634d2..f78307e77371 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6381,8 +6381,7 @@ In combination with KVM_CAP_X86_USER_SPACE_MSR, this allows user space to
 trap and emulate MSRs that are outside of the scope of KVM as well as
 limit the attack surface on KVM's MSR emulation code.
 
-
-8.26 KVM_CAP_ENFORCE_PV_CPUID
+8.28 KVM_CAP_ENFORCE_PV_CPUID
 -----------------------------
 
 Architectures: x86
-- 
2.26.2

