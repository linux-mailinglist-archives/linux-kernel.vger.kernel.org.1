Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2DD2D4BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgLIUeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbgLIUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:34:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5D4C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 12:33:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o4so2024032pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S+Qm1Txt09YzglGXS4N1LSBJ4tWItqAD7fi2vPq4Ppk=;
        b=Fcyib7dQRAzrbHKqf1ilBMCQA3ASKgY3eBGvWNNpQ2PWuhwZP7jncRukeZDZK7gNRC
         CLogErUqYuG/4O4ZooIPcL7abErRyDIy66cTt8GojzDTjrUiYFeHTKrO6aMD1WDI9JlW
         5PE5pASI+ez65+RAMHh/Tokz7aQmiZlYZ5ysIHKy3/XkYWkj0/WO08Rkydyrp3RTHipD
         VtZiMrn4tRVC1a/rn0KW6Hv8wmhIacpe+jJg3wcIR/v7gh+8dcLKfbVfibYEhsZFXS8n
         Lb8j0m49jLCtbalkgpy44iXb1DNYGxD3ff5RSRGwQ1xYp83RXUJrSQOB8QADW1SpvgJ3
         BaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+Qm1Txt09YzglGXS4N1LSBJ4tWItqAD7fi2vPq4Ppk=;
        b=YRkAjZu+FpyeyK+EaZsp+VRctz2RDRcsH+dAoolCT08yH+sPA7/6rbcuhRvaot1S77
         vYvfVO6bTThCeHNwZbP0odJ96t8D0yFAmaHcpogRd11v24zVLQcDWGkN+mZK4zRCPACQ
         SXqGMN6ljJFMZoP2YJEUAaRRZ8sEpQ3lSwzu32RL0fIwMKWDjD3+optgxgOgMEsRSld8
         jKMKpG2BmunTEXy7BKxglza/TicrKO73Fm084nzQNjoUdU2/HIM2zSP7R83SwEDtC9wK
         2uqSZ77wVcOOPU0YZDO0XBQv2kXBI7syjGqiLg+WN/YvjBWlMeNKyN8HEMknqeP2mDJd
         Itwg==
X-Gm-Message-State: AOAM5300TbtTifC5QuJEQ7+C5jIjrJS/75Frmm81rppRahzOaVRRdn5D
        mU9Nv4vradBqSH2JaNSZNxnLbw==
X-Google-Smtp-Source: ABdhPJzMfIQyr8v+bNxTQhdSP69mFCO2iwcAVPwUBTpqrxRkjJvC63JtqzVhQ9O3ctQeQ4a/fh7VcQ==
X-Received: by 2002:a65:68da:: with SMTP id k26mr3486564pgt.303.1607546007805;
        Wed, 09 Dec 2020 12:33:27 -0800 (PST)
Received: from google.com ([2620:0:1008:10:1ea0:b8ff:fe75:b885])
        by smtp.gmail.com with ESMTPSA id u4sm3451748pgg.48.2020.12.09.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:33:26 -0800 (PST)
Date:   Wed, 9 Dec 2020 12:33:22 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     thomas.lendacky@amd.com, brijesh.singh@amd.com, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, seanjc@google.com,
        tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, corbet@lwn.net
Cc:     joro@8bytes.org, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, gingell@google.com,
        rientjes@google.com, dionnaglaze@google.com, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 0/2] cgroup: KVM: New Encryption IDs cgroup controller
Message-ID: <X9E0kl0+9zGSnIu/@google.com>
References: <20201208213531.2626955-1-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208213531.2626955-1-vipinsh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 01:35:29PM -0800, Vipin Sharma wrote:
> Hello,
> 
> This patch adds a new cgroup controller, Encryption IDs, to track and
> limit the usage of encryption IDs on a host.
> 
> AMD provides Secure Encrypted Virtualization (SEV) and SEV with
> Encrypted State (SEV-ES) to encrypt the guest OS's memory using limited
> number of Address Space Identifiers (ASIDs).
> 
> This limited number of ASIDs creates issues like SEV ASID starvation and
> unoptimized scheduling in the cloud infrastucture.
> 
> In the RFC patch v1, I provided only SEV cgroup controller but based
> on the feedback and discussion it became clear that this cgroup
> controller can be extended to be used by Intel's Trusted Domain
> Extension (TDX) and s390's protected virtualization Secure Execution IDs
> (SEID)
> 
> This patch series provides a generic Encryption IDs controller with
> tracking support of the SEV ASIDs.
> 
> Changes in v2:
> - Changed cgroup name from sev to encryption_ids.
> - Replaced SEV specific names in APIs and documentations with generic
>   encryption IDs.
> - Providing 3 cgroup files per encryption ID type. For example in SEV,
>   - encryption_ids.sev.stat (only in the root cgroup directory).
>   - encryption_ids.sev.max
>   - encryption_ids.sev.current
> 
> Thanks
> Vipin Sharma
> 
> [1] https://lore.kernel.org/lkml/20200922004024.3699923-1-vipinsh@google.com/#r
> 
> Vipin Sharma (2):
>   cgroup: svm: Add Encryption ID controller
>   cgroup: svm: Encryption IDs cgroup documentation.
> 
>  .../admin-guide/cgroup-v1/encryption_ids.rst  | 108 +++++
>  Documentation/admin-guide/cgroup-v2.rst       |  78 +++-
>  arch/x86/kvm/svm/sev.c                        |  28 +-
>  include/linux/cgroup_subsys.h                 |   4 +
>  include/linux/encryption_ids_cgroup.h         |  70 +++
>  include/linux/kvm_host.h                      |   4 +
>  init/Kconfig                                  |  14 +
>  kernel/cgroup/Makefile                        |   1 +
>  kernel/cgroup/encryption_ids.c                | 430 ++++++++++++++++++
>  9 files changed, 728 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/admin-guide/cgroup-v1/encryption_ids.rst
>  create mode 100644 include/linux/encryption_ids_cgroup.h
>  create mode 100644 kernel/cgroup/encryption_ids.c
> 
> --
> 2.29.2.576.ga3fc446d84-goog
> 

Please ignore this version of patch series, I will send out v3 soon. v2
has build failure when CONFIG_CGROUP is disabled.
