Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9CC2ACB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgKJC2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJC2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:28:15 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841F5C0613CF;
        Mon,  9 Nov 2020 18:28:15 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n129so12074659iod.5;
        Mon, 09 Nov 2020 18:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=keYF4CkgxzM1pesky08YWn1U5fRMi55bwI9myTqfa/U=;
        b=A1HUlEtAojTRba+JWBSh6M5Xdhez3Q1OvSMAOSpYW3rjeKA70euFOGo/ncD2l69gPJ
         a5nHSD3s9GgjnXKmijeWT1YdOh2NiDod7oBqRiSPb+ykJM7RNK1EAxc2tzRfzC8R2SFA
         /L4YlOoE3zb9lBTg/hYUY3xCCIw4iQ7S2VvDY0nQLaHiR5eGqyYQ1NbgeDJRpigpLVXz
         Ux2FWSv8yYa+KVwKmaVxf4je9mDJyBCnDY8F2qIxDkqnMQ+5dObw7TXqhBIDqGH2PcB9
         /DKOTj6vasZ5f1D5mkqCduukNOfo4zSFwIPcb4NYM3n8GGUyeMkzWjc9+ML8aMTiewhz
         ojGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=keYF4CkgxzM1pesky08YWn1U5fRMi55bwI9myTqfa/U=;
        b=LR1wpUVzNPxEDuOR0/+XLD4hrY9oR84SRZmjEcShdfUicDUW/yCClST+d63n9Cm/i8
         qNNE5oNocnlJGrjVMUcdm8823tg//Tk+oVp2JCxF2OWbpToZsYZTriMsRojx2QDgW1zw
         6PH+lmTp4rBX7pOfZJ5nMxQF4iRRh0LhpjTFKh+38EhURcYS8J6g1Frx12IPE5zI8Eg0
         +9VJ6PHe+G8WEizOQHwPSaHc0dkq8su+Q5yr5/4cG+JJ61ec0WR9N/eEfycIE/h1djUG
         LfFItXxCflNxxrVCv5qZb8ll2/u8Am0ZG8j637R0OtUsjA3xs7ruvjvi2XsJBAUcwJ/8
         b7Mg==
X-Gm-Message-State: AOAM530OcbmLLGr/Zo0Cua8HujJPkLHoLWYwlKenqzJCL+4VuZfrQh1j
        gzMAVb5fUSpSBj7k6QD2RNjiJ9dTC2+inB/1q6liRrhDrdFN+Y/K
X-Google-Smtp-Source: ABdhPJxDwrptMszZuKk2HnOQoODlBjgh6e630cLHfANreTNmB2DtR2JbwwGbwINv7gukrkuDGa/4uKyWHpXngx6bsiY=
X-Received: by 2002:a5d:9842:: with SMTP id p2mr12619519ios.113.1604975295009;
 Mon, 09 Nov 2020 18:28:15 -0800 (PST)
MIME-Version: 1.0
From:   app l <lipc198702@gmail.com>
Date:   Tue, 10 Nov 2020 10:28:04 +0800
Message-ID: <CAGaOi3Z5ezAiBB4-YxUa+so1s=PnVzVsfw9rAs3CGKExJHD-ow@mail.gmail.com>
Subject: Question: gadget: How to realize uvc and uac composite function?
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Version: 4.9 and uac1 driver is V5.9. I tested it based on 4.9 with
backported dwc3 driver frome v5.9.
1. According to configfs-usb-gadget-uvc, PC(Windows 10) can get ISO
data normally;
2. According to configfs-usb-gadget-uac1, PC(Windows 10) can  install
audio driver normally(AC Interface,/Captue Input terminal/Speaker);
3=E3=80=81uvc+uac1 composite device, PC(Windows 10) can get ISO data normal=
ly,
but PC shows that the uac1 driver installation failed(AC
Interface/Capture Inactive/Playback Inactive). AC Interface/Capture
Inactive/Playback Inactive all show the device cannot start code 10,
The settings of the I/O device are incorrect or the configuration
parameters of the driver are incorrect. Through the USB analyzer to
capture the packet, I found that the Index value seems to be wrong
when PC host to get the descriptor. The acquisition is Playback
Inactive and Capture Inactive, and the PC did not send the command
packet about uac1. It is difficult to debug it.
I suspect that some parts of the uac1 descriptor need to be modified,
but I don=E2=80=99t know which one to modify.
I sincerely hope that everyone can give some suggestions or related
patches to help me. Thanks very much!

Regards,
pengcheng
