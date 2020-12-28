Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098052E698C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgL1RFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:05:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:48645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgL1RFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609175051;
        bh=I7I3MJiRsH7GsWwbA/YkRX/Cu7MJG7ubX1PNL3in4Xc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=H6gtohWxEUkYMMuzvsBIDbhXANYD6GZ27EifBEk/EATTRldn3k0BxIV2CJHH6+1iX
         ybPNd2EP1Xo0Q/GsHT1SzMQSgMOKBba/Ovv0bzJdJyE2NRCnzbE78gumozPHLO0a03
         9rNGzvXgotx6BG3nna/84iXkVBx5qleBuUNMHDGc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [5.186.118.182] ([5.186.118.182]) by web-mail.gmx.net
 (3c-app-gmx-bap26.server.lan [172.19.172.96]) (via HTTP); Mon, 28 Dec 2020
 18:04:11 +0100
MIME-Version: 1.0
Message-ID: <trinity-0333c9ff-6ccf-444c-9b6f-f2b4412342a3-1609175051562@3c-app-gmx-bap26>
From:   Hans-Frieder Vogt <hfvogt@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     zbr@ioremap.net
Subject: [PATCH RESEND] ds2490: prevent dead lock during detection of
 w1_therm sensors
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Dec 2020 18:04:11 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:nFdfge/fQa6R3rmSvdqD73Gbm3/iib23YsDGgkmNswYrifeZWkjlbp1ZvLbcBSYdXU76s
 HuVxaigs+CE+A14s7dU1dBv7iJDfYHFzuQ+o93qFKesxqAC8LihDhgiO+FIFGmI65Dgpz4SuNKGr
 Liv6sY3CCyWhSqrVZNJlvWTTlHGa7tt1g34DVSPP8AcAa+Ta9w2S4uB7TCRQtGGb8RDjY4jZtyo8
 eo3FoPIVrFJEqSeslbWc3fEOH5/YFfJM63HjipvC3iyBL4PUg59FgOPOLyoCpx1qL8B3Bt70JoEn
 ag=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wBfyb3HnEJk=:BiI7qvy1vFmUmv0R2Z/U7e
 dv2uLIphoi1KKl9J2dZ9MT/5NDvsV9qr2U1FjewtxsY7TNC6C2dgxM5HRTWYyOhv3Ho+Gtd9R
 o3EwhvjSAFcKdzBkYUqIOoe1bXxyzo4UYq+btAx52Nbj+SneQmCWVcJ1SXzbbBgGf38DSMKr7
 xVf4aut7BSF81fSGSp7fEbhQ3NeTx2YNz4D78NKL5TyQR1A9G7a+OHN1MUr/uDNTz4/UgNijx
 X+70GHcn4QWx3EkGQOofmwTmsuPJ9UyNHV9HzbfFzHL2CaeAfjkLY0Nl1q1+AgQPNXNm5uuzY
 5gbBtaonS5LxV4i692UFIIJd+2PghLTl4s+T2nrPowPAEdGQnZZ7R9ttdPzDn27V/i5T+jqfA
 8Zipxy1XRucf1CG9nOaCkXPOUjmhrIkegIM9OlsgNEk2zxQ8Az6bq+oO+wnGgym4yHYAzMA1Y
 v3sP4FaLNrQaenRh8IBKpDJsYf9jzaQ87meJaNnIB4RHI+W3qmiNe8zv2VHmDjVs/5LJcoXpY
 2Qr8Hd3y//P3Ue6GlFz7zZWk40NVQ4Ycbe2dDIWHlsBY+FSiGcIqZNzwekb9U0AY0V+6CMSzy
 5Fgw/IatpX5P4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(patch resend because seems to have disappeared)
with the introduction of the ext_power sysfs entry, commit b7bb6ca17a90f47c2fe2848531b5bbaf27a65ba7 (w1_therm: adding ext_power sysfs entry), a bus locking error got exposed in ds2490:
bus_mutex needs to be released before calling the detection callback during search, otherwise a dead lock occurs with sensors which try to lock bus_mutex themselves during detection. Please find below a simple patch correcting this.

Signed-off-by: Hans-Frieder Vogt <hfvogt@gmx.net>
---
 ds2490.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/w1/masters/ds2490.c	2019-06-07 23:43:07.783820179 +0200
+++ b/drivers/w1/masters/ds2490.c	2020-12-28 13:22:28.963946366 +0100
@@ -730,8 +730,11 @@ static void ds9490r_search(void *data, s
 				break;
 			for (i = 0; i < err/8; ++i) {
 				++found;
-				if (found <= search_limit)
+				if (found <= search_limit) {
+					mutex_unlock(&master->bus_mutex);
 					callback(master, buf[i]);
+					mutex_lock(&master->bus_mutex);
+				}
 				/* can't know if there will be a discrepancy
 				 * value after until the next id */
 				if (found == search_limit)

