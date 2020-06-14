Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3541F88A0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgFNLb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 07:31:27 -0400
Received: from mout.web.de ([217.72.192.78]:39831 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbgFNLbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 07:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592134272;
        bh=99e5fUmdAPxpyhSRJewC1/udHxWyON/Mb6axo3Pi7nw=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=RKUhYc0rWQnux02Ro1wBTLVZ620PnblMZuUuWhzu7KyGcMPzXoBahzGOYt9IN9HXG
         zMG2SQsNxuOiN/HwWo8U7yMwbQgZ6YPAWM6zqhDDvy/pma2JpMLdlws99KlcXYQM7q
         6JfGX+shsCiswN1PhQRiAPDsf+dkgyVAKkPmEh8E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.103.145]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MK24P-1jjc2f0ABp-001UNV; Sun, 14
 Jun 2020 13:31:12 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: fix ref count leak in
 panfrost_job_hw_submit
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bb7c5ba8-92e5-c286-2599-a567597821bd@web.de>
Date:   Sun, 14 Jun 2020 13:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FsG0eqYQUCEy4oT1KD7RmUvTHqavlg8gPF9F86wn8DMkMvTzQDX
 YP1vg91L0AKDAgyaBEyyzUnFCY0wgSQ1jxF6IKlteMeilE5ROn0DtKo+Jrw9o23RpGBMGsA
 4jhSE47VLdztPsd0k1mCgQuVv1Hnxb+vCIop51fPUupHQsA16ia2HTdB+yN1Q8H9U5e/Dct
 oPtG9gbi+rKImu+/9zHRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vkz9YcZtDLc=:xFIj4LbjypOPfz4KNO+3fR
 53NmeJ5v4rwxm01VNKBknqh3J+o3hGrEnMlRZOvLAEjNA9V+tMNGekOPsHHZ1ECfUTW0I3AVg
 UkBEvSumu0Qkb6VKvox/lDfRB74tmGJiUe2wyElut9fyJpwtMzRfBi4QXrAsURHlsCPUVE/KX
 fz6jnxDccVX7Mf2tlPWM12Z7HLt6Y27fQhXY5ZfueoAdoK1iu++AEOQP8tsgkf14tGRqTgP6b
 djVZxCX2UfkOCKfxQhArsLXSr49U6KID40DlcF5HR/CToyUXkf5Fi3TQ2YNq2oVNWtLfueE0R
 Ovxt+taJZdIGMGsaCCvYsjt5gQFAHQeKaI6NZVv2cpP0UN14b9URgKvkGiiW1NCYs6VJ+4s/a
 wrl1Sb7hRnPtPc8lAVlGyHco56UzUQ/IseSsbTU4Tt2lPSNA8m4OnUWWVkGLHr14ePEN+OHA/
 Wtb0euIAJWUGrJHAzVZ5Kh4EXpAPME7BSmcqyyzELN7pjIT/UuszRqcjDJe2DKVOKs6FInH/d
 8U51sLPUPvhITDxzdRvnEC8eRZgmCYaDOoRUzi1eQNaUAve1JjuDAflv+J2tqLHxSrwtJuzOu
 CO73q7pH5wxGzYAvCAbDZ7glM5tzEC5HzeYTiRc+m40sF+gnnb020yq55TXa/FyOkUWaoamlo
 44fc8fFudesBZr78IuYRQnAAD/0aypuet2GQ7FXg6YBZdXZPx9d34U/T65C3wC+pdTNRH6eDi
 fjGKvswDVc7KDsuU6prw0oxZkSL11Ob/JJREKNgDxfSKALmrLuK9lZiM7Dl6IU1i7p/mssorJ
 jo676wBNtxVTmvweWIbEbqqkMs1VLav+fHQO3PY3BO7VCUUFVmkOeGyfN/wx5+6Y+LjqoY/9T
 EGo7poSSWqS6D/OxxkPtttHiJSnMnmAY97AVweuOVJBRgLjgrqNBbylPLRDSDmVaICzHJB2tH
 S9ffQRmPUqiEOe0SaXADEHRXfWE62GGt5ZhHcdbEL7oa9hOo5x3rWuBlF6+uL0Gj7EFImIPpX
 Vz1eZXEU16a6jD7lt2VDDQlRXokSI0slT/MG0PdpydNiQidBqN6fkujMOdQvJc6M4FXGXZpeC
 5kBTVYhpwVnuE6kT+rkwZ/TOh5Z2rhUCSZw+fKnKLrbjdMZqNLQV8hTiMSsNV6bBUEQoANs47
 gYTkx33Cx27CoDVGu71SNg0BlmREEJ17/76oAHQA/wgnQnzp2xnPqsWVNKGdqFGC5aFhMUrSU
 2AcqmezIZP3l+nmyn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> in panfrost_job_hw_submit, =E2=80=A6

* Can the term =E2=80=9Creference count=E2=80=9D become relevant also for =
this commit message
  besides other possible adjustments?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?


=E2=80=A6
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
=E2=80=A6
> @@ -184,6 +183,9 @@  static void panfrost_job_hw_submit(struct panfrost_=
job *job, int js)
>  				job, js, jc_head);
>
>  	job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
> +out:
> +	pm_runtime_put_sync_autosuspend(pfdev->dev);
> +	return;
>  }
=E2=80=A6

Perhaps use the label =E2=80=9Cput_sync=E2=80=9D instead?

Regards,
Markus
