Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1819EAAF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 13:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDELX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 07:23:26 -0400
Received: from mout.web.de ([212.227.17.12]:54247 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDELXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586085787;
        bh=bgK3xwLWxipoZhNigNcDnx54QrzQkey9ZhjORtkbjjg=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=TJrUOVGFnJnDWw5QZ0Vmt3bld9nMEWR7VBpaCiQAQPn/W6XF2R4Yw8YI6a+mWnWoj
         7wX+X+oqNrsL8wFKGi8vxKub5/2NGkHtkg0qse7vyg45/t1DZRzPJv9vGHZk089Khi
         0BjaBXNg40qkgb3LOy3wJIMNb9P6+OQZnETi7iew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIvPJ-1jIZKE2XAf-002XIo; Sun, 05
 Apr 2020 13:23:07 +0200
To:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/meson: Delete an error message in meson_dw_hdmi_bind()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <76f24122-4d3f-7670-9f06-edb4731a0661@web.de>
Date:   Sun, 5 Apr 2020 13:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jIH44cL5ff/53XO6FY9rhkiaPwSihkaHpVJXF9fblVIPyKl4nQc
 x6S1oCrQA/3nGj8URCr/aMXDXsPukBZP4UlgtBGpU9uNHtkGEIr+T2isVdSjYo/pwGt0WpK
 3nZ9xsPoErd91by17YD+wnwyQCIDH9Bz3J9ta17KopXSx8agKBJxBw/7dVwIunWGLfD1719
 daMeVctCru9sbm7t2EoCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4HRCdynSaAk=:Q/tIEajrmy/O/1iFN2xcAR
 0YXl+pGmfqrDXeCctVU4GITDp9Wdmc4tbh3JWTXzy9BPEY7M8xRdREH665Vq53tB7RDv4GSKe
 SD3cqyyUjXryiAu9DzAQIHtDKmA0TRhEIm5Ek9dHntH5H7ievZ1YPHtG+VyF5wHvCExHLZIXl
 MlnoBH0/wjUuoOkxhIpbS6IQP+06wwn72yIIubdk/zy2nFsKUu5VE9prKgSUY/FeqxpUp1Q8H
 rwlHEnI6kSrGd/ZDD1YhQ2LTLL0KL/5cJQzlM700P7oMMWVlqzSsY/48A94XMoBBGmJtTnthJ
 NeZSTpTUcriGoLhkqFOHjxXu0IZKyO00g5ZlEGo6XpQdb4rFSyFxTXoENzOyw47d0Uwe9V0yp
 QJ0Wss05HEXmTPKntOqaU0C2bHmU6Dll1ZCczdazdYbMmykNJ7m82daCZ898TlrGXkUXABnla
 hcG+a/Ku3RSrpOR+8DiH4yOQHkGVz17DOp+8I7fbpWfbnguXamhtE7vWzszVEHJp18eecyt0x
 4U46F9AW0eVkZs3dGHZhjO0H7wB0YqFO18gGgumWqE5vUCqtklCfqqvn6DqnR7A4XU2a0lyS+
 8/Jcb3fAr6t/M0N/CeCdFlnrpNH/VQvm9N/zcMcgKW3ZVjO+3XE6iEBECzNrGSNckCR4xYuKt
 J/WJ85/rLxO6AR2DwmlyTmocY2u7Od/dGiJCQtpEbL9pe7KBG29wyo0CPDvHnof8VBn9jvFMr
 yVDI9aeVr16KyjDR7Yu+nlW+Pog7MQLrBb5fcAt7ksjClFmjz9od0X479/ZEJfGJMCviGrsn0
 EXLwMGHZBbfPWOcQUhoTPi6RDgOdVzqqbgGzouc38Okx8tXQs5MX7+F2ie9SsmtnLQgbWHhMs
 /BPn5N1qaP7wnYTfMSZ9K/VM06in1VQG6c4/qsEJ1VKayw7Guma329HoODqMziK0chawTMVlf
 rXfuW3iUsCluUibtkS1typOXeRNnPvueJY6/Ybjy+Pbr5zb883teoX/wuid6lLh2o6/R2j9ck
 D2ysLV6IV3FJoA3Kwj4pEhm6VguSKZbvJPhbnBEhh5LNu6wBNT/3+MtWRDRuNSk8WPi7wRMDj
 0lKajTGSfuSenekl3HNCOT3MfAWcyygw4FU344hotes9UPY1/p1vtz1afWZPNFUXAewGUWNGD
 PgnsXnjBDNg4bW1vaT4yVUy8MvvANL+dE6BR2ZRPUDOsMIZ9P5YDgOQGGOZZUPIt9GVGGkID1
 plaBipocdjPhxmnJ4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Apr 2020 13:13:03 +0200

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit a redundant message for the exception handling in the
calling function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson=
/meson_dw_hdmi.c
index e8c94915a4fc..64cb6ba4bc42 100644
=2D-- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -1034,10 +1034,8 @@ static int meson_dw_hdmi_bind(struct device *dev, s=
truct device *master,
 		return PTR_ERR(dw_plat_data->regm);

 	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get hdmi top irq\n");
+	if (irq < 0)
 		return irq;
-	}

 	ret =3D devm_request_threaded_irq(dev, irq, dw_hdmi_top_irq,
 					dw_hdmi_top_thread_irq, IRQF_SHARED,
=2D-
2.26.0

