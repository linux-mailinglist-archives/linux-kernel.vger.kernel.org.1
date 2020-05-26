Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25231B8F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 13:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgDZLDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 07:03:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726227AbgDZLD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 07:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587899008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRG3wb+HfKLYZc12zNwv5CO7j5yWInoHWZ1aFwKrIxE=;
        b=SRVgBaohmvP9I7viXXmnrSNKSVP5wOv2R3ZIfQjPm0KeJDIek5uf5o/75A3ujzoD/BrVoT
        CzOSkQQnZ8ngSbxWs0GvOljJ3tyCbjc0c56YZX89EqHxNDnsO8VTcwNRA0V16TwscIJkwJ
        SN9oAjBlfZIeugwFDBkzNr6a0NxKoNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-pYmJho1LORmTytu4ZqOb8w-1; Sun, 26 Apr 2020 07:03:24 -0400
X-MC-Unique: pYmJho1LORmTytu4ZqOb8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6BA745F;
        Sun, 26 Apr 2020 11:03:22 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 333D410013A1;
        Sun, 26 Apr 2020 11:03:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 8/8] iio: light: cm32181: Fix integartion time typo
Date:   Sun, 26 Apr 2020 13:02:56 +0200
Message-Id: <20200426110256.218186-8-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-1-hdegoede@redhat.com>
References: <20200426110256.218186-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix integartion time typo and while at it improve the comment with
the typo a bit in general.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 878fc13632d8..50cfb7d189df 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -237,7 +237,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32=
181)
  *  @cm32181:	pointer of struct cm32181
  *  @val2:	pointer of int to load the als_it value.
  *
- *  Report the current integartion time by millisecond.
+ *  Report the current integration time in milliseconds.
  *
  *  Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
  */
--=20
2.26.0

