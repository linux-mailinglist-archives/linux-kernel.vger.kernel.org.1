Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C62304DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbhAZXOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbhAZFJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:09:19 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC40C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 21:08:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d4so9179400plh.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 21:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=FU71qPbIJQVTuxT6YbCDyAvn+zOVqEswtHSNOm8FjI0=;
        b=Xhu/uOys82DIaKhKIWPIOFCE+R/lI/8W9VQ12UqkRsnR2WYYvyGb5vYTUwDmE39gg2
         oyuI/FBGErVKFGrytbnMunurR/1y4by7R3UaxrH/dWmhJAmMergoLtpg5amFowBZoDmI
         kAjKCrbP6BpuzCCgb8Vv+Ftu4AMzeF5k/VDiRqUBdvzHFRvkOMfTrqIyLnvuJO00+bax
         xCK8y/Pw1UwXXPG9FGbzS+13SlgWQKi2wIuPDB1mCJFBTd35J4foW9JD+yDHOSygLWHR
         cZmA8YwyGOIsoOvm6/JozQExERFKYmknox+Y2nkjsY1H9JaOajzEJKbMrD2Zn6BAQ5Rv
         9u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=FU71qPbIJQVTuxT6YbCDyAvn+zOVqEswtHSNOm8FjI0=;
        b=YHTPtatz0e/jkVezZkRy7H1hq1tWlAVqLVuUDdv3aQ2OCUnRVwFLv5qiDUfmQG3BOh
         qXQpGauxzJ2rH7kFzIscfVrmmU0uQ62MdyakNKN0MvRDeoeTjaZKfBbMPgV4SM/VvOlp
         WhTlnl26q4rhEijrXsvcxqitGXrPVBJPiiISuiO/unG7CIYdlEXh2N7UYx9CYNSOBYDd
         JFfwg3t4FsiIz5k9084zdLemmQmcHYWwjVZ3d9Nsh2ZDzJEWkCnpojpYcEma77A10fk+
         n8UrKfRgJ2gDgAukRHkKPiKGEYW7mY0/0QUOIDqGyGL4Q+yGb8h29P5ntVbrQWteBHXX
         Q2/w==
X-Gm-Message-State: AOAM533XDS7hl9VkQSrHdoRDGpyhBHlTSWFpN8EXbuNiHvhVBeCMXjC7
        WmdkarHxAkaWtfKK76am/j/InA==
X-Google-Smtp-Source: ABdhPJyfHrpS93QjLT54XIVTxubgwCp8usm7xe/w0kMToYGrbPz6QqD6EeIEfcusqUuEtd2A4GZnZA==
X-Received: by 2002:a17:902:523:b029:dc:1aa4:28e7 with SMTP id 32-20020a1709020523b02900dc1aa428e7mr4379086plf.4.1611637700060;
        Mon, 25 Jan 2021 21:08:20 -0800 (PST)
Received: from x1 ([2601:1c0:4701:ae70:dd5e:ff29:33fe:cad2])
        by smtp.gmail.com with ESMTPSA id fv19sm933893pjb.20.2021.01.25.21.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:08:19 -0800 (PST)
Date:   Mon, 25 Jan 2021 21:08:17 -0800
From:   Drew Fustini <drew@beagleboard.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: pinctl.rst instead of pinctrl.rst?
Message-ID: <20210126050817.GA187797@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was having trouble finding the pinctrl rst documentation until I
realized it is named pinctl with no 'r':

Documentation/driver-api/pinctl.rst

Is there a reason for this?

Is it worth me submitting a patch to rename and change tree-wide
references?

Thanks,
Drew
