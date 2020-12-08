Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF02D211D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgLHCsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgLHCsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607395634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8+7V7y0HIXI/xTSMeK5TyfhDNBwKA8kJHkCRAiUG/o8=;
        b=LKx9O9LSonLkXF5ZDYknLdTpvUzQnJVJm/KaMrteWs3svwGf+H/5wfWEDazjw8ZGOjja4S
        XhL3B2UA7LlW185IdrtUVaDN79tSTdU44S0WbXPCXaIHtYzQtxWP/EMl4lixshWZio+HeV
        Ac4zp7KJgNzliJcqf1c86vhpUEDF3Fg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-5_TY4PAmNgaOIJ3HUSFi3Q-1; Mon, 07 Dec 2020 21:47:12 -0500
X-MC-Unique: 5_TY4PAmNgaOIJ3HUSFi3Q-1
Received: by mail-qv1-f69.google.com with SMTP id e13so13211246qvl.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8+7V7y0HIXI/xTSMeK5TyfhDNBwKA8kJHkCRAiUG/o8=;
        b=FGTkSbncFUGa4G/X7rt8KjhmAf5lJeSSqChyFgj9GninRHIpL3tPOVjK/AtYGGj59v
         YRfV4sa9yDi17UnvuAhJ/7VXJ7hbN32kWB7VKDMcA8robWYFaiQxQPyThsIaeZO1S5y+
         X9aPZkyq/rO97GSXoZ8oq3mgwe9Jk1K3oAC/SggdKh5LWQRr8rjrS20hSEr+sMbYyHg6
         BjARO9JPbq8F6AcvsoqndzTIUcsTvjVf4LF/yD6YpcKRb8glSIoNSL/UTwpfBSC6RgBL
         QxW+lsYsAppLFkPsSI4P5FXBZeue1B+3eaAoOmfIazVkkaZr0thXLXNQ5moDDpmzRtUa
         +gWQ==
X-Gm-Message-State: AOAM533sesCpNDL89330wS8MxU330R74SjLXcpSVDQM2R0BqR0ykXfHw
        47BthBHljdj96AQaiUQ17UZaohr2BN+eUCCD/y/Srsmd1zsO+dJMjUY8aIygcNTNOuvUNQ50qP7
        qNZ1/q/qkkfUKmLvzVu4mpAZ2T+sceCtpbXmiRuoAMQvgso7OwqQgsCtCWtmkYCZjwVqoavWVBA
        ==
X-Received: by 2002:ad4:5106:: with SMTP id g6mr24489267qvp.1.1607395632096;
        Mon, 07 Dec 2020 18:47:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYqzv5UAFy9ozPhjRIis99B7Wq3J7T4C2Xd+HoXJsFJ8yTrkyjZlGmcTvrwF1ubyT8TVjXeQ==
X-Received: by 2002:ad4:5106:: with SMTP id g6mr24489246qvp.1.1607395631823;
        Mon, 07 Dec 2020 18:47:11 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id n95sm13778744qte.43.2020.12.07.18.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:47:11 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/3] userfaultfd: selftests: Small fixes
Date:   Mon,  7 Dec 2020 21:47:06 -0500
Message-Id: <20201208024709.7701-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There're some very trivial fixes that I kept locally to userfaultfd selftes=
t=0D
program.  Please have a look, thanks.=0D
=0D
Peter Xu (3):=0D
  userfaultfd/selftests: Always dump something in modes=0D
  userfaultfd/selftests: Fix retval check for userfaultfd_open()=0D
  userfaultfd/selftests: Hint the test runner on required privilege=0D
=0D
 tools/testing/selftests/vm/userfaultfd.c | 13 ++++++++-----=0D
 1 file changed, 8 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

