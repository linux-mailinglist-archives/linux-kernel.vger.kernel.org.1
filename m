Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F32773D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgIXOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:23:02 -0400
Received: from tritan.municoquimbo.cl ([200.54.193.62]:36342 "EHLO
        tritan.municoquimbo.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgIXOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:23:02 -0400
X-Greylist: delayed 5132 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 10:23:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by tritan.municoquimbo.cl (Postfix) with ESMTP id 22373106AE858F;
        Thu, 24 Sep 2020 09:37:12 -0300 (-03)
Received: from tritan.municoquimbo.cl ([127.0.0.1])
        by localhost (tritan.municoquimbo.cl [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9Jag6c_itFtX; Thu, 24 Sep 2020 09:37:11 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by tritan.municoquimbo.cl (Postfix) with ESMTP id C4EFC106B37968;
        Thu, 24 Sep 2020 09:37:11 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.10.3 tritan.municoquimbo.cl C4EFC106B37968
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=municoquimbo.cl;
        s=2A3F0C56-58B3-11EA-9CA2-CBA6DDB4CFD7; t=1600951031;
        bh=MXuIWqoGTiZw9vrIn5xOkHDgnMMOV5X6DHQprRBo9jQ=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=dttolWeKB2v9/6ouxESF3D5QdTwQL5kFaWyGFP1lCsX6tjtf/IvmYJS+C8krygEyi
         X2aPeojlq2seF4Q8M1zMdlEEWQCIOpVVPLwDBqcYqJucGce58xd66TbQMAhZHJO3o+
         rvbF3N0Mk2FdP+S3lRIOZJMJN0WEdU653BA0gYt8=
X-Virus-Scanned: amavisd-new at municoquimbo.cl
Received: from tritan.municoquimbo.cl ([127.0.0.1])
        by localhost (tritan.municoquimbo.cl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WqaMwM5byBDU; Thu, 24 Sep 2020 09:37:11 -0300 (-03)
Received: from [74.208.157.156] (unknown [74.208.157.156])
        by tritan.municoquimbo.cl (Postfix) with ESMTPSA id E088D106B05D85;
        Thu, 24 Sep 2020 09:37:07 -0300 (-03)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: KINDLY REPLY....
To:     Recipients <patriciagarrido@municoquimbo.cl>
From:   patriciagarrido@municoquimbo.cl
Date:   Thu, 24 Sep 2020 12:32:48 +0000
Reply-To: mrchenhk101@gmail.com
Message-Id: <20200924123707.E088D106B05D85@tritan.municoquimbo.cl>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=municoquimbo.cl;
        s=2018-02; t=1600951031;
        h=from:reply-to:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding;
        bh=MXuIWqoGTiZw9vrIn5xOkHDgnMMOV5X6DHQprRBo9jQ=;
        b=rCd2dTbrn4u+DYpIKBK8nzGYIwHwJKyDleqb2WIp6RU081gT7rpzrhXqi3rNZBZUan0Wrs
        YorCBBLcVG581q34qadpjXMR9xc/DNDBCM4SwSqX9ZxY+OBvNLaZSG/PcnBAIzypX92Hvy
        iF6Tk+XX3+64srbUUevLsYxzjV7ques=
ARC-Seal: i=1; s=2018-02; d=municoquimbo.cl; t=1600951031; a=rsa-sha256;
        cv=none;
        b=VXWLbTbfTg69hmz6H0IEsdib9i7BvHc5+bqlmJV1pjrhEnW+9zNvBG0fSacvlz+VRyWGj3eCEQZmRdyTDNN7/siYs0u4p7kzwzw8jiFun3hekgSONq/YA8cQPTcflWhDqIq9ci6CSrOKFNSSwaqMjwmugmaVYkmlRJ5gKU7XN8M=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=patriciagarrido
        smtp.mailfrom=patriciagarrido@municoquimbo.cl
Authentication-Results: auth=pass smtp.auth=patriciagarrido smtp.mailfrom=patriciagarrido@municoquimbo.cl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=municoquimbo.cl;
        s=2018-02; t=1600951031;
        h=from:reply-to:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding;
        bh=MXuIWqoGTiZw9vrIn5xOkHDgnMMOV5X6DHQprRBo9jQ=;
        b=sLW965RkcSi3e924kQglEO2aY2HQFfkbuGe2cb2Zdw/aUkwkLRaYVqYeX57ZSFwymn+l+9
        qWZ/Br5iD8EyGoeWgMygaMR94X4LZzwkMq4siS46kGHGnE0ApzA2ccAJAqtP8fK9Dv8I/g
        t4VfJaPVCd4hiKtNTNKIIaMJJ66t7co=
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am very happy to contact you for this business transaction.Please
kindly get back to me via this email: mrchenhk101@gmail.com for us to achie=
ve success and secure a good future for our families.
