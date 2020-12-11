Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34D82D6FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 06:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395267AbgLKFqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 00:46:46 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:13705 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390420AbgLKFql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 00:46:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607665576; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=j+DfFGxWs7c2CmyMKyBUPlymDbEjwgO5qYBJpQVMWy0=; b=D2Z84005HPA/74XtTqzL/8rM0uT015SjmzTRaHsaB778O7fWjAh3oPnwkhSj4upldWT+qewq
 gZjBJrOKAi6rsYD/wrPCpHrp/9bSpCkgcCwjw0sc3Sq9CIlLu9045rRsn2o3Y8RKI89d9XO0
 KYD3dxyw0YsBzn/1mAh4S+wB4+0=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fd3078e3a8ba2142a769f6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 05:45:50
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E241C43462; Fri, 11 Dec 2020 05:45:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from Pillair (unknown [49.205.247.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FB96C433C6;
        Fri, 11 Dec 2020 05:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FB96C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Brian Norris'" <briannorris@chromium.org>
Cc:     "'ath10k'" <ath10k@lists.infradead.org>,
        "'linux-wireless'" <linux-wireless@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        "'Doug Anderson'" <dianders@chromium.org>, <kuabhs@chromium.org>,
        "'Youghandhar Chintala'" <youghand@codeaurora.org>
References: <1607612975-5756-1-git-send-email-pillair@codeaurora.org> <CA+ASDXN4uLsbo7uuO7WPaUBY+mqHQRfdMHJ4R9KBqqmiVQJUcA@mail.gmail.com>
In-Reply-To: <CA+ASDXN4uLsbo7uuO7WPaUBY+mqHQRfdMHJ4R9KBqqmiVQJUcA@mail.gmail.com>
Subject: RE: [PATCH] ath10k: Remove voltage regulator votes during wifi disable
Date:   Fri, 11 Dec 2020 11:15:42 +0530
Message-ID: <000301d6cf80$e0c44150$a24cc3f0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHPTk2hLG94YXWqoxGOXZeMCAI2cwD5rb8pqfiXg6A=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, December 10, 2020 11:44 PM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k <ath10k@lists.infradead.org>; linux-wireless <linux-
> wireless@vger.kernel.org>; Linux Kernel =
<linux-kernel@vger.kernel.org>;
> Doug Anderson <dianders@chromium.org>; kuabhs@chromium.org;
> Youghandhar Chintala <youghand@codeaurora.org>
> Subject: Re: [PATCH] ath10k: Remove voltage regulator votes during =
wifi
> disable
>=20
> On Thu, Dec 10, 2020 at 7:09 AM Rakesh Pillai <pillair@codeaurora.org>
> wrote:
> > --- a/drivers/net/wireless/ath/ath10k/snoc.c
> > +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> > @@ -1045,14 +1085,18 @@ static int ath10k_snoc_hif_power_up(struct
> ath10k *ar,
> >         ret =3D ath10k_snoc_init_pipes(ar);
> >         if (ret) {
> >                 ath10k_err(ar, "failed to initialize CE: %d\n", =
ret);
> > -               goto err_wlan_enable;
> > +               goto err_free_rri;
> >         }
> >
> >         return 0;
> >
> > -err_wlan_enable:
> > +err_free_rri:
> > +       ath10k_ce_free_rri(ar);
>=20
> This change in the error path seems to be an unrelated (but correct)
> fix. It deserves its own patch, I think.

Sure Brian. I will post this error handling fix as a separate patch, and =
also post a v2 for this patchset.

