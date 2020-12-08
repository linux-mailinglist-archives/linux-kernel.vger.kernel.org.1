Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D792D2126
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLHCvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727702AbgLHCvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607395826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7rs2RpyvCt/qw3HvG1MCXjLOMZiVbDYQ2DA+7d+wtMU=;
        b=NpoZXPpPTkjtFTTN0CynRpdXG3HbGNNhkYvQh6K0vngbCIjuJ3PDXlgkOVOac0SLkATsug
        MPCPGLFU2TtxIkHre4MG5sEm92j+jb6wubq3NE+FGaP+wWeiuHTrgf8jtARDz9rfVx01Gc
        2mpo3aB54UmwN0Ush6zDM0z5annaqeA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-JRRkZu50NHKYBY8kC29Y6g-1; Mon, 07 Dec 2020 21:50:25 -0500
X-MC-Unique: JRRkZu50NHKYBY8kC29Y6g-1
Received: by mail-qv1-f72.google.com with SMTP id i11so13209319qvo.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rs2RpyvCt/qw3HvG1MCXjLOMZiVbDYQ2DA+7d+wtMU=;
        b=B4ALiRtHi/XWxwKUZj0eQkZQivJooARzsV0wpxT1AZ0GXogSxErjG+zT4PCe7nnUdR
         IAFsOzOPSP3FilubCS4q7I0PwRUhIkJEGTdVte8AfX4lbyBo67fSz7y4+zQ0XnrCr1yr
         TSvyfHe17s0yWspLEEQlkZ8g6EyRvjPpL3WUWFlm/7FM9VsxeNKFYriN2VscTEGdBQPu
         L7siSLvHQ7xWTpqLpC3nj066u4LsC9i1Js4d4yF9+9FOQSVjhIzSZcQUXUflC5XZYmqs
         VAQ1Qy7FfE62ZxnoLs+1rTC8zPFEgPzeVkUcNOcmdD1TTse4hoKCz6Z4tjgm3iCbTEh4
         ojIw==
X-Gm-Message-State: AOAM530EA6QSEhHI8PyER0RBZW0yDIxVMB+YACxB3SRo/ryOf9kPmOSo
        Y6MissE1iD5If1ns8m+bRHBGirdgaN6CE9PoN8DXk8vdkUD432q95aTyAo3fTnHi+gXWKK6Bb6q
        tSR+zuQ0XOADUVY+L06WzVPxHxwYnzzoIRbSqAf7ofmSzqkt50HnYB4+3CwBDrqJiq0J9pemcJQ
        ==
X-Received: by 2002:ac8:5bcb:: with SMTP id b11mr9471285qtb.336.1607395824523;
        Mon, 07 Dec 2020 18:50:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzByd/f3jFo26m/hR4nvm+gPoV9HQS0xND9194MQz57nD2XbF4GRi0GUGfs2AZl1cMOMwo17w==
X-Received: by 2002:ac8:5bcb:: with SMTP id b11mr9471272qtb.336.1607395824281;
        Mon, 07 Dec 2020 18:50:24 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id a28sm2632766qtm.80.2020.12.07.18.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:50:23 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] mm: Some rework on zap_details
Date:   Mon,  7 Dec 2020 21:50:19 -0500
Message-Id: <20201208025022.8234-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posted this small series out to rework zap_details a bit, before adding=0D
something new in.  Hopefully it makes things slighly clearer.=0D
=0D
Smoke test only.  Please have a look, thanks.=0D
=0D
Peter Xu (3):=0D
  mm: Drop first_index/last_index in zap_details=0D
  mm: Introduce zap_details.zap_flags=0D
  mm: Introduce ZAP_FLAG_SKIP_SWAP=0D
=0D
 include/linux/mm.h | 33 ++++++++++++++++++++++++---=0D
 mm/memory.c        | 57 ++++++++++++++++++----------------------------=0D
 2 files changed, 52 insertions(+), 38 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

