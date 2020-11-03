Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961502A3CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgKCGLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCGLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:11:38 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E042CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 22:11:37 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id k3so3112903otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 22:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUQECi2b2OmyDRScJrepUtAejD+g0Cf0SRxo1IXKJxY=;
        b=AGsR20jXoMdzQ00xNiD1IByazVm3Bjl1NGCQe8DmtoViitMuOzzhNDj4356l6HRndU
         ufR3hTueJY933LmLdYrDp/+7G4OrFkaq+aICNtNkYiU81Hlistf3a185hBRPZBl2qrLa
         mGIysGc0x1l6nhMqd79AcDLH3YFYF8nkkWhYT0aBHEvcA/9cT+BWFJd85Z8Q7ZqI9Im+
         4jnrw49j2InpIIHwzfjMTPqeYejLKOxS6BKTfgqsr2gxDZdRkBj5I2d2HtKm7NtcuqY0
         PJE+EqBMSGrGq4i94va785QaD4H4c28JVorFUqDcArbglf8zJOWO04u7YD50eu2oWLnA
         692Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUQECi2b2OmyDRScJrepUtAejD+g0Cf0SRxo1IXKJxY=;
        b=cqsoeQhvX08a9PsJctyGw7Uw6MTgguvRmAdwAG01XLWoW1Ag5uWZgvnImGuDIPSKtr
         3yvWG38oDCuoaRiTEzyUBKE5im09kmv2JdVBALxpYukIhAn7JPHlLNsFIWr7wM7nzIcy
         P5GeH6uxw1/Xlxv8xI7pzcalWCs8ko3yg5aNFqGsYDTzYn0mw0NBmm4bewsoj3TR86/M
         kUzGy7xQ8S2/0YdQahn/D3Ag6vMYzLYTHULBDLI5Bk3vPDlhYT5UCseyAQf/G6oBL0NR
         Xy5JjnB6+OLCjy1pa3xoybHm7l8GWuXNyONXRFsygcW6RA73zprm9zNxnalwHJQmmNP8
         O5FQ==
X-Gm-Message-State: AOAM531/x7fU9oo9qULk4stw2o17ZCFmf4FrewyJEMQFjTCyuJ6Fc165
        +cIC0+UnZSyPEf2bGB5OOk8oDCZKXgza7TIVD6JrHQqVZTM=
X-Google-Smtp-Source: ABdhPJyauU4JLerz1H5+gLLJB3GH4BxZ3L8r2UynN2PUKLok0mhN5q3GnRNnc8QUueR3kZObrzxW7/MHby1sWLLv8ZY=
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr5385725otp.102.1604383897321;
 Mon, 02 Nov 2020 22:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20201026180026.3350-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20201026180026.3350-1-sudipm.mukherjee@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 2 Nov 2020 22:11:25 -0800
Message-ID: <CALAqxLVzsQs6_G9DOTkaBsUa93-97c136mtx7WRPNjBFjfkyAA@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: use PTR_ERR_OR_ZERO
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:02 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
> we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
> doing 'return 0'.
>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Thanks for sending this!

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
