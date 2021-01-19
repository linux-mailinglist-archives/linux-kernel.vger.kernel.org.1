Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16A2FAFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbhASEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbhASEmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:42:36 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0649BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:41:13 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id o19so10419003vsn.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxguhV1s8HV3uAUmVwAP9veGFogzAl9hGJElFs8+sg8=;
        b=hxGX2VCaRgK3TvZZyA8vqpQ2j6H0o61h6RRTo9JBmAzOhsbRmzDyNPj1THO/XvyUNQ
         rIMldKA4xhJw2A9RBASR1qcsG6gfaASGhm8dBLi+aEDbMDosMn+2u7d2KMvIKGpALrza
         bIgHYeCTjKR+g0Pv+pvm5pjtV8YVXUl1Mfsmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxguhV1s8HV3uAUmVwAP9veGFogzAl9hGJElFs8+sg8=;
        b=IWH8JVZwAOQVzlb0OSNkk4GpgZGr4Fmqp42V4zjj4K8LLKPkm/ojmAy8InOdVQSzOp
         XAr3LBZ50pj2ZnwwvbqlOFh1+c6TpoYZwWvXSMNnF/zHSgni0xZR5MzVP6a0gsxXBRrs
         cRdRt5QVT67VA29h+VbPnOmV97xsnJUhifBo59r84MZnPl2nspVic1AYxKL/+0HKO8as
         grwh+mhA41/Q7JWq5aViV4HF23EyuZU/U4EujzDhpBrEezqi8gZjqV+gjBIsAcxd6po1
         SFRzDFUzVotdS38//T+wPFo0P+G3v30kXU7i6s1PrtET73T85tqqRB1H/RaqgMslQCjV
         R36A==
X-Gm-Message-State: AOAM531vtxtjehA1NtLwlcjXCnfLsktMg1HQbKkDnuGb2F0Dnkhfciap
        a9sScqav0AaGx5JwdA9W1w54+rZ2HTaJx6cbNvj8MQ==
X-Google-Smtp-Source: ABdhPJxA8jB0M5xWXyVXiqZcPqj9OdGAv+PXrO558oWbMQsvIBtm4qP2VW4HqOedGoX/qqA1bnUWBUcg3z2XrMGSKF4=
X-Received: by 2002:a05:6102:66a:: with SMTP id z10mr1655865vsf.53.1611031272168;
 Mon, 18 Jan 2021 20:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20210118112827.6192-1-max.chou@realtek.com>
In-Reply-To: <20210118112827.6192-1-max.chou@realtek.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 18 Jan 2021 20:41:00 -0800
Message-ID: <CANFp7mVrUCyhs3jaNLC6fbOQGxfG4kgVQ69rKyS6urBM54SWKg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btrtl: Enable WBS for the specific Realtek devices
To:     max.chou@realtek.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Lu <alex_lu@realsil.com.cn>, hildawu@realtek.com,
        kidman@realtek.com, Shyh-In Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Mon, Jan 18, 2021 at 3:28 AM <max.chou@realtek.com> wrote:
>
> From: Max Chou <max.chou@realtek.com>
>
> By this change, it will enable WBS supported on the specific Realtek BT
> devices, such as RTL8822C and RTL8852A.
> In the future, it's able to maintain what the Realtek devices support WBS
> here.
>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
>  drivers/bluetooth/btrtl.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 24f03a1f8d57..835819c47ae6 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -38,6 +38,19 @@
>         .hci_ver = (hciv), \
>         .hci_bus = (bus)
>
> +enum  btrtl_chip_id {
> +       CHIP_ID_8723A,          /* index  0 for RTL8723A*/
> +       CHIP_ID_8723B,          /* index  1 for RTL8723B*/
> +       CHIP_ID_8821A,          /* index  2 for RTL8821A*/
> +       CHIP_ID_8761A,          /* index  3 for RTL8761A*/
> +       CHIP_ID_8822B = 8,      /* index  8 for RTL8822B */
> +       CHIP_ID_8723D,          /* index  9 for RTL8723D */
> +       CHIP_ID_8821C,          /* index 10 for RTL8821C */
> +       CHIP_ID_8822C = 13,     /* index 13 for RTL8822C */
> +       CHIP_ID_8761B,          /* index 14 for RTL8761B */
> +       CHIP_ID_8852A = 18,     /* index 18 for RTL8852A */
> +};
> +
>  struct id_table {
>         __u16 match_flags;
>         __u16 lmp_subver;
> @@ -58,6 +71,7 @@ struct btrtl_device_info {
>         u8 *cfg_data;
>         int cfg_len;
>         bool drop_fw;
> +       int project_id;
>  };
>
>  static const struct id_table ic_id_table[] = {
> @@ -307,8 +321,10 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>
>         /* Find project_id in table */
>         for (i = 0; i < ARRAY_SIZE(project_id_to_lmp_subver); i++) {
> -               if (project_id == project_id_to_lmp_subver[i].id)
> +               if (project_id == project_id_to_lmp_subver[i].id) {
> +                       btrtl_dev->project_id = project_id;
>                         break;
> +               }
>         }
>
>         if (i >= ARRAY_SIZE(project_id_to_lmp_subver)) {
> @@ -725,12 +741,16 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
>         /* Enable central-peripheral role (able to create new connections with
>          * an existing connection in slave role).
>          */
> -       switch (btrtl_dev->ic_info->lmp_subver) {
> -       case RTL_ROM_LMP_8822B:
> +       /* Enable WBS supported for the specific Realtek devices. */
> +       switch (btrtl_dev->project_id) {
> +       case CHIP_ID_8822C:
> +       case CHIP_ID_8852A:
>                 set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +               set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>                 break;
>         default:
>                 rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
> +               rtl_dev_dbg(hdev, "WBS supported not enabled.");
>                 break;
>         }

There is a null-check on btrtl_dev->ic_info right above this switch
statement (https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=b649813eadbc062d8682f7a20aa025275707dd1f).
Is this still necessary with this change? (Sorry, I missed this during
our previous review).

>
> --
> 2.17.1
>

Abhishek
