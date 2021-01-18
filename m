Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF54D2FA28B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392681AbhAROGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:06:50 -0500
Received: from wrqvxvhd.outbound-mail.sendgrid.net ([149.72.168.13]:3708 "EHLO
        wrqvxvhd.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392649AbhAROGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:06:31 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2021 09:06:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nmaggioni.xyz;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=s1; bh=+Oyl3Q7NQOoHP94ZarboMQQ/J+LxJwfdx5og4VGdP1Y=;
        b=oTqdg6ykLK3D0vWAdnC44WEtsRBM8P8T83oFWnIuZqZ9AEupCASBfan6Q4koHo6dR2g8
        l0o5VsR0tbiK6Ps8bmhqeWC28JFWoXkPy4WwTrx1z/Tl5rbon8DdECCXYirzOioIB0fKVl
        +kAoS190jq7oO08KTSp6YPMmvLNh0/4Pk=
Received: by filterdrecv-p3las1-d5b58bc9d-zh724 with SMTP id filterdrecv-p3las1-d5b58bc9d-zh724-20-600593A1-4C
        2021-01-18 13:56:49.862631744 +0000 UTC m=+318780.108459485
Received: from atlas.mhan.lan (unknown)
        by ismtpd0004p1lon1.sendgrid.net (SG) with ESMTP
        id nm2_cwaEQrKFNW0vNMLYKQ
        Mon, 18 Jan 2021 13:56:49.533 +0000 (UTC)
From:   Niccolo Maggioni <nicco.maggioni@gmail.com>
Subject: Re: [PATCH] drm/i915: Force DPCD backlight mode for HP Spectre x360
 Convertible 13t-aw100
Date:   Mon, 18 Jan 2021 13:56:49 +0000 (UTC)
Message-Id: <20210118135642.69287-1-nicco.maggioni@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <7436CB1B-FB93-4D74-84E2-B7CCB9E6C38C@canonical.com>
References: <7436CB1B-FB93-4D74-84E2-B7CCB9E6C38C@canonical.com>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?VTCxX6Y8XXRdgALr0K3TrzIQZDQ7TZCjrbs2158ctlk5C1v1hd61LdA8DCVRWA?=
 =?us-ascii?Q?Hh15TrofmMmvgdzdg=2FfL50fDknPiQNF6nf+p89C?=
 =?us-ascii?Q?H5UPk37ERVkp7Cq=2F8fKAaWdAMo7=2FDq0S=2FhvaYE8?=
 =?us-ascii?Q?u5UhMagsCErW6xTMXLyEfDB+SFsa=2F8O4nqHC4Xc?=
 =?us-ascii?Q?VcZdNHu7HsDDEMHo3CY7heobECsvdhDVuggVPlN?=
 =?us-ascii?Q?4a4ubaQo9WbbkB=2FCEU52WfFJozfCQMcptYtydFy?=
 =?us-ascii?Q?3VW2xkyii1rl8F55dVPK7vVrsAkAigOxtzUTbG3?= =?us-ascii?Q?uRI=3D?=
To:     airlied@linux.ie
Cc:     kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        Niccolo Maggioni <nicco.maggioni@gmail.com>
X-Entity-ID: ePbgsBW7WebxXVZpKRwyWw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another gentle ping, this patch is still needed as of today.
