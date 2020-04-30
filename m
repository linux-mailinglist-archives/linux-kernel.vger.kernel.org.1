Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD31BECEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 02:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD3AUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 20:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3AUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 20:20:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15350C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:20:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d25so3231338lfi.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=s598r/7kUjIC6HAMYR5ml+jwLPdPDke+4dCrGdi46QU=;
        b=ptgD7AWHf9KfscYWvafhJgNUjANXN9zqYdVoBiNSn51Y+pdUW1CFnS0VkU1jh5Qaqx
         HGCylIjpTzLzU3hy9ehhUnPAIY/lEiGMFpwc8fai7MlzB6bam33GTHGItyQqBM/mU1t0
         Icz/wGGAvHZfo98fh5mP3WZcPdCRKTymzpt9hw/Ap9OOgswseV+1GtTr2N0/5mBkY3xn
         Mb7x1nE6XFSSwQp5n9YaNvPRs0GxG+K9CHqnckLsTDySuvyL4bEQIhi4LZA/xv6pd4EE
         JQT6RZXud6RSF/ztUx0pLXM6nGG3cIg+cE6MznK51SiacvMW55GZxXdnhVhHyGjd00Rh
         TnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=s598r/7kUjIC6HAMYR5ml+jwLPdPDke+4dCrGdi46QU=;
        b=iMj8lF57xym9Nj9cX3mdYrpL7I10KzAndHryg1HDGXQnK8oj6JAWC6Iar6SKo6i08/
         k26fGWT78T5eRlqM2QuAaxasyBmUCrH5PgJVRiXQjxXH1d5gPJx860XlOD6SS1/nTvdr
         jrDqiT0nQqGRkeam+Pmursrf7XPsA0nTK78eVAXJpeeZePmCq8snDTMz7K9qH3hWogKc
         VsGdEFCeEJ4Txu9JaR3YE4TjyL0Lo3FNxFGl2e6haAOjPiZKjNJpL+REZ5k26Do3OY1R
         DUETzewFd/MnYCOTKl48SuSkmGqOKdT6kOTPzXzeRdDmy7UgiMY0VT/ur+ARhNuz4y1l
         aGfQ==
X-Gm-Message-State: AGi0PubgX6OyL4IjKLlgsFJ58VLysl5gwSuBE98G7Ado0Lj+xGTvXLBt
        AJfOmqh03ZS5nmCQ8dMGn4vEr3X/YJVr8PTBsg==
X-Google-Smtp-Source: APiQypJ+S+zWYNH1WPqxBkhn7oTtluJvxE3ShVFev3d3rO0wnqzQ20RbWn+uo0pBBTiY8CCMsr4qcGbcwImL5DKg9M0=
X-Received: by 2002:a19:8809:: with SMTP id k9mr241010lfd.151.1588206036454;
 Wed, 29 Apr 2020 17:20:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1207:0:0:0:0:0 with HTTP; Wed, 29 Apr 2020 17:20:35
 -0700 (PDT)
From:   Mohamed Abdullah <mohabdu0011@gmail.com>
Date:   Wed, 29 Apr 2020 17:20:35 -0700
X-Google-Sender-Auth: RwLDP2rz9htGWuGw7MzDnjnlS7k
Message-ID: <CAO=7yz69VgYgxaQcrN7KY5xJcvgzu+d9Zvfe4Gg8L+zHTUDGNA@mail.gmail.com>
Subject: REPLY ME IMMEDIATELY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXNzYWxhbXUgYWxheWt1bSB3YSBSYWhtYXR1bGxhaGkgd2EgQmFyYWthdHVoLiwNCg0KSSBhbSBN
b2hhbW1lZCBDb21wYW9yZSwgdGhlIG1hbmFnZXIgb2YgQmlsbCBhbmQgRXhjaGFuZ2UgYXQgdGhl
DQpGb3JlaWduIFJlbWl0dGFuY2UgRGVwYXJ0bWVudCBpbiBteSBiYW5rIGhlcmUgaW4gQnVya2lu
YSBGYXNvLA0KDQpBcyB5b3UgYXJlIG5vdCBhIG5hdGlvbmFsaXR5IG9mIG15IGNvdW50cnkgSSBu
ZWVkIHlvdSB0byBoZWxwIG1lIGluDQpyZWNlaXZpbmcgdGhlIHN1bSBvZiAoJDUwLDAwMC4wMDAu
MDApIEZpZnR5IE1pbGxpb24gVW5pdGVkIFN0YXRlDQpEb2xsYXJzIGluIHlvdXIgYmFuayBhY2Nv
dW50LCBJZiB5b3UncmUgaW50ZXJlc3RlZCBjb250YWN0IG1lIGZvciBtb3JlDQpkZXRhaWxzLg0K
DQpZb3VycyBmYWl0aGZ1bGx5LA0KTW9oYW1tZWQgQ29tcGFvcmUNCg0K2KfZhNiz2YTYp9mF2Ygg
2LnZhNmK2YPZiNmFINmI2Kcg2LHYrdmF2Kkg2KfZhNmE2Ycg2YrZiCDYqNix2YPYp9iq2YcuLA0K
DQrYo9mG2Kcg2YXYrdmF2K8g2YPZiNmF2KjYp9mI2LHZitiMINmF2K/ZitixINil2K/Yp9ix2Kkg
2KfZhNmB2YjYp9iq2YrYsSDZiNin2YTYqNmI2LHYtdin2Kog2YHZiiDYpdiv2KfYsdipINin2YTY
qtit2YjZitmE2KfYqg0K2KfZhNiu2KfYsdis2YrYqSDZgdmKINmF2LXYsdmB2Yog2YfZhtinINmB
2Yog2KjZiNix2YPZitmG2Kcg2YHYp9iz2YjYjA0KDQrYqNmF2Kcg2KPZhtmDINmE2LPYqiDZhdmG
INis2YbYs9mK2Kkg2KjZhNiv2YrYjCDYo9ix2YrYr9mDINij2YYg2KrYs9in2LnYr9mG2Yog2YHZ
iiDYqtmE2YLZiiDZhdio2YTYug0KKDUwLDAwMC4wMDAuMDAg2K/ZiNmE2KfYsSkg2K7Zhdiz2YjZ
hiDZhdmE2YrZiNmGINiv2YjZhNin2LEg2KPZhdix2YrZg9mKINmB2Yog2K3Ys9in2KjZgyDYp9mE
2YXYtdix2YHZitiMINil2LDYpw0K2YPZhtiqINmF2YfYqtmF2YvYpyDYqNin2YTYp9iq2LXYp9mE
INio2Yog2YTZhNit2LXZiNmEINi52YTZiSDZhdiy2YrYryDZhdmGINin2YTYqtmB2KfYtdmK2YQu
DQoNCtmE2YMg2KjYo9mF2KfZhtip2IwNCtmF2K3ZhdivINmD2YjZhdio2KfZiNix2YoNCg==
