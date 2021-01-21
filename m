Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138C72FF477
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbhAUTaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbhAUT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:29:05 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9383C061756;
        Thu, 21 Jan 2021 11:28:24 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q205so3328783oig.13;
        Thu, 21 Jan 2021 11:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uIqOfM2nGNmNmW5GJyvb2PshT2T7EyDIFenfC9VbZOU=;
        b=atyPr/ZW5t2Vmh8IYjskk56vqMkIZlf54X5VB04CS+lG7yxeVFwaYNEUbqr7RfjfVl
         AFTDH1wxOoUuLIWtSKG0GNgIzjyn1e3WisT4OD3kT8cc8/tngthFA8CHlXOAnp+cguXo
         lWgOBTQJPud3Qgv4HaDjUs19PIk169NpZ3xrja8eXzcGmCbPRsxsg7AOZtspWpldy0gk
         LaqQCtkKThy9iMFR0cKrVXgjeLmk3yixSa54m+fUdOUheUUuxgDmtTwzaza47MFxui9u
         A1JdNXY6M0RdxvoIpS8DKw6RkB6+JGZE9LeG6w1giWBF2DiGYsUOAG+g7eGlQLjkYDjA
         tmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uIqOfM2nGNmNmW5GJyvb2PshT2T7EyDIFenfC9VbZOU=;
        b=MKxAPjQ6ItN9Zi2aCFvn/t5gcEUpZEWZGFFIppo9beOR4LGMz6ul549H2vZWAVv+mF
         q+v26n1Qhfj+eGk4KubsLZl/zZsm23YXX1k7Qnxz6C/xcfcVeXhFGluadpIFWJpRjiYw
         5bw+Hb0TGLWbhSn2z2t12pvom6amQmV6rNjGZYVkGtqx0dvrufQaJwF8alxkVG891u14
         lOFOi9jBgYe0NDpHsO7JRMmgqvQ2yRpkekfqgFLuuFCLMrKJIx/7hwXtalsFBHDZtgg9
         Alk6Q2oIAFbcBga/1TXyqRmgl+K6X21M9Rqmt7hd4WtztqpzTghcsnEUmHQ0CMP5rZFV
         M5FQ==
X-Gm-Message-State: AOAM5325aWRKJA5WvgZ7wDt+cfp7vZyF5vp873dwSDZIHgDHTkYfnrGY
        NXrLGQNvC6sewuQ3UdEwFxm53h+t408=
X-Google-Smtp-Source: ABdhPJwmpUeOJD8jIymEPDsXht34jkpccZE07uKyfStQg796SoOxuF3uCfkUEbCCUIIeiRSSaBgYug==
X-Received: by 2002:aca:5185:: with SMTP id f127mr861048oib.18.1611257304238;
        Thu, 21 Jan 2021 11:28:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s69sm1238876oih.38.2021.01.21.11.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 11:28:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Jan 2021 11:28:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] Documentation/hwmon/ina2xx.rst: update
 ti,ina2xx.yaml reference
Message-ID: <20210121192822.GA31091@roeck-us.net>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
 <886bd248721b146d844d46e26ddd4cd277f51446.1610535350.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886bd248721b146d844d46e26ddd4cd277f51446.1610535350.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 11:59:17AM +0100, Mauro Carvalho Chehab wrote:
> Changeset 94f1ab944565 ("dt-bindings: hwmon: convert TI INA2xx bindings to dt-schema")
> renamed: Documentation/devicetree/bindings/hwmon/ina2xx.txt
> to: Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml.
> 
> Update its cross-reference accordingly.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied.

Thanks,
Guenter
