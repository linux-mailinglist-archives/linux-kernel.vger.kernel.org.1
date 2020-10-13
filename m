Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBA28D383
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgJMSSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgJMSSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:18:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69880C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:18:31 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id m11so883576otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ndksaFxJGum/T29wsztvmBsRVqTpAzOmyLVoT9W775s=;
        b=HNZHHeLI3/M/5BTbBIqwEMhxPJyhx4GLkLzyXjXjJ1B/4yCL/65pB3l2KOM98tTm9l
         WlTqLUHNzIMPr6mjEC0Db5rX6NE701P4BJsJ/fBl8BV+mWddGW/TjJp/zvWbLpi5JDEZ
         qz9iD0EwGvCVtggFG4dofTQYVSIpG1wDRl0EnNswQXbphv26mT4RPAPAnf0XOY0GVN1a
         9kgrwqa8X23IVJT8vuuOl/JcAkkCbWbXcSljpn2JvuIgKY2Nhh573mCUEaQGXqvE6+ld
         IEEf4TVbKHBJBkK9p9OatFYe8SZ+CB+X64jynCJfCyvVNWSgAa5VO/ZvZotAoHB8/Rtd
         wqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ndksaFxJGum/T29wsztvmBsRVqTpAzOmyLVoT9W775s=;
        b=MvV3vOM61a8Zy55FGD3Xt7oAHBpBoQfC33+8lLlKuXEXyjBvS8y1LebrmF0MXncquu
         sQ/A39yjwUoCegjHS9ARjHf4STCSNiFsie0NTCX7fRwMj1zqZ6NIQA8iUX0V37mJwLwH
         oauuG8SPr5AN6ZvAJKlO9LwZaGwGLwYjTxJmY/ZzIGdDGhe+aSkS5PVPqyIKCVbz0ZzI
         MqN0d5Wpbka+5J8BA0j4iqXidX4VQ0lSTkRkPFpREm8K1dUJ9tlQ7QHOkm5QUkBsuRgo
         xikbe7hgp9V0VMKCXXf643lqAYjmKIUi64TisXfGoHN6wHS2WctojW8fXItN4cgWTbHj
         V+DA==
X-Gm-Message-State: AOAM532uRWHtnX9TJOon2J9jHDaevCUB5a3uWMZduzNxhbA+/LsDXuta
        W+8YC1Niipf2jUGVAk5S0aWOIoujHEUUEzpZhTMZOQ==
X-Google-Smtp-Source: ABdhPJwXCc0TdHV3OXiJpV8vpOXdZc58NqcBSEh4CHGEPZOevTGroj7Rck57xeqqoXd4KsmZ/B9ac+9lMA16OOIpEL8=
X-Received: by 2002:a9d:4b10:: with SMTP id q16mr685860otf.274.1602613110369;
 Tue, 13 Oct 2020 11:18:30 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Qiu <xqiu@google.com>
Date:   Tue, 13 Oct 2020 11:18:19 -0700
Message-ID: <CAA_a9xLcCuR+WFfNtpJgq14rGZfxcqsoVz5aNhL5XCLhV+TwNg@mail.gmail.com>
Subject: RE: [PATCH] hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_1
 telemetry for RAA228228
To:     Grant Peltier <grant.peltier.jg@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Vaughn <adam.vaughn.xh@renesas.com>,
        Guenter Roeck <groeck7@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jason Ling <jasonling@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Intercepting the email thread...)

Hi Grant,

Looks like you made a typo in your patch:

> + case raa_dmpvr2_2rail_nontc:
> + info->func[0] &= ~PMBUS_HAVE_TEMP;
> + info->func[1] &= ~PMBUS_HAVE_TEMP;
> + fallthrough;

Did you mean "/* fallthrough */" instead of "fallthrough;"?

- Alex Qiu
