Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793FA28EFE5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbgJOKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbgJOKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:11:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 03:11:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x13so1727616pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version;
        bh=3ZvuqU9wO0QXs+fFzUr+4uuLIYSBct3ObczACRRbQ/Q=;
        b=hZHGeRJkMfHKrZR7M898sdxEprSwRtpdZm7BpPnaGmoIyKBjYHHsJDqGUZ2VgE05eN
         dIVj6b6w/+Bi5xdU4UoovTvhK5XTjn1AD3JzlBY32U8fUpo343c9H1622jfsdrfBohqK
         BR0lp8UTWdsTthScObKhlOOgie3I3vBtU0a7NZ7ItnuHcASwyOjnEHl9FN+6uRvgbiK2
         vEKJKC2iP+zNsLjb630FuSOJamduCTg3OyJXHmPZOBZhXH8DANG2XUG9KtshBhExeqgA
         e1WdvNZR9lukps1LXqqluWAO9u7IpODp0GDSzE1Pa8rrGuOQblxUSpMU/HTP8/sJ7+Q0
         Yu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version;
        bh=3ZvuqU9wO0QXs+fFzUr+4uuLIYSBct3ObczACRRbQ/Q=;
        b=JLKCJddGN25c2AP97PaoFQXNDR47DX0qjwT71afLx5C+PAOufbXBzCP9BdwbMJZIV3
         pwFL4lwSm6PiAKONGhYerMbJS6Jmp58gzP3wA5ziuJkeZ9VUF6cVp3AJ9ZEBb1zo+rgp
         z41RWUdDPI3oGU3fFaz661wIteJHRDlc7Sz0vl8QtreuvSYn/fFIjsLn2nzZWdwvD7D0
         ilEXlrrHj7kzzKjg+1zhQvbAYC/qpah4Nhdc534KXcAkrT8JlhsMSwxCerKHvc2mZ3xj
         t1G4hCbbgtxL+w0BRBJrJWYAYfWXd1SKPO0pf7l4CAMaRV9sdgvf1RQFruDi9WJKmVAq
         xplQ==
X-Gm-Message-State: AOAM531bi5Yb+mQhyP9W35BqzmgwTZBf2aJfJBUFY10myhsZS5fpc0Fo
        JfyRYIAG5MK46Nv3TtGivM8UO3PRvZE=
X-Google-Smtp-Source: ABdhPJyM7nF15g/5Qm+Hel0uvR4Y+mNvf/l5Et2riy7h2d2Rof+fXQRquKTOkGOkzD15U3wzVdu8rw==
X-Received: by 2002:a62:5f02:0:b029:13c:1611:6536 with SMTP id t2-20020a625f020000b029013c16116536mr3334830pfb.8.1602756704052;
        Thu, 15 Oct 2020 03:11:44 -0700 (PDT)
Received: from [10.55.3.106] ([89.29.209.221])
        by smtp.gmail.com with ESMTPSA id gd14sm2798397pjb.31.2020.10.15.03.11.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 03:11:43 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   "David C. Manuelda" <stormbyte@gmail.com>
Subject: zram NULL pointer dereference (zs_malloc)
Autocrypt: addr=stormbyte@gmail.com; keydata=
 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 dun+
Message-ID: <2f2dd548-c79f-a398-6d11-1d616ec8c57d@gmail.com>
Date:   Thu, 15 Oct 2020 12:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TF26Msmu6Xpl2heDhCvBZww6WJRmlj0d8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TF26Msmu6Xpl2heDhCvBZww6WJRmlj0d8
Content-Type: multipart/mixed; boundary="yYov2EcsoVMwXyuBRVWEhnJTZRwX0D1s3";
 protected-headers="v1"
From: "David C. Manuelda" <stormbyte@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <2f2dd548-c79f-a398-6d11-1d616ec8c57d@gmail.com>
Subject: zram NULL pointer dereference (zs_malloc)

--yYov2EcsoVMwXyuBRVWEhnJTZRwX0D1s3
Content-Type: multipart/mixed;
 boundary="------------2C51C2A1FB877500362B5862"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2C51C2A1FB877500362B5862
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

I found a serious bug about kernel NULL pointer dereference when using=20
zram (in my case zram+btrfs) that makes system unstable and usually ends =

in a forced unclean reboot like powering off power source.

This issue is present since >5.8.0 version (this one seems not affected) =

and still present in 5.9.0 and reported in=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D209153

Since this issue seems major enough, can someone please review this issue=
?


Thanks.


--------------2C51C2A1FB877500362B5862
Content-Type: application/pgp-keys;
 name="OpenPGP_0x2D7138D2C33652B5.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0x2D7138D2C33652B5.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBF9OwCwBEADseTaibYLhZHmXWYyaRxrG82IIBjJ/BOWf9X35Rokm3lxegDHHG5kBxznBY=
Vbj
QTz5NSqoUCup+ljqUIJi80+Oa01QwYFQYbcGGkzyt47BUSOlUq+KQWeozs0XolIX8qyqm4uSN=
x9c
Q7ggMPEpDZnIsk6YsAKukMDZfLBtuIYpb+wStGFcJys0RgpXKvOVx3pua1AU+/L9oxcYK57mQ=
0+1
3xROWY5oZeM/hY82MLZ9zsplgewg7T1PHI1ZHnzqS4SYXC7iVrwNOLjcwyihf/cKWxF7j1wHq=
hO9
SiloQ0nULOeK1Oxrke+hr9Cq3MtoO9WqNUfggmkavB2Rm1PbGh4EzxeUEvVE5StaccPLvcJxs=
kKt
QSmqXcmi+/0Rt3uqW9x0ewZ5dQR5gBm0DxfZcLVHUQqIPZQd2pbUzJEqliC/jlp4lc/BW2cXl=
XuE
hnntBsASUDMZRmwIee/lne1QjU1fJWH+NdDRoekw3S5assAhTUW+S7kWbOOKGvFFItEArM8Bv=
6eR
eFxvbylkaGKCKOTnEY9IbnSerfDR2MFqsfyVXpI2rBV0f0XseC/HQRYy7tp4kvQFp2OxAbv75=
8Vw
GcBS/CYPwqnW1mKJ0/aTQyqlFm7VkdEzhXSIfXHDAG5TOBlJ0eBwtJ8hiqkTH6wyBu1SoJjsl=
jZp
oulOHiU5cv+PGwARAQABzSdEYXZpZCBDLiBNYW51ZWxkYSA8c3Rvcm1ieXRlQGdtYWlsLmNvb=
T7C
wZQEEwEIAD4WIQT9alnJFnSCZga2qb8tcTjSwzZStQUCX07ALAIbAwUJA8MT9AULCQgHAgYVC=
gkI
CwIEFgIDAQIeAQIXgAAKCRAtcTjSwzZStdD7EAC63Cr5sIxGXl/GV1llObhtAm5VWGtwh2N+o=
EJg
+Hdv27rd47EJZ/ni6QLCtq9emZ9aaTWbEBo+PlvevkSonlEyzbJHGC6Or2Kt8cx7Ipd+4U2qs=
Rxl
Hut5Iqkn2pEvuEmddq9UAKq7it90eQKyFtCSzJZospgxcomlmpNMLlb8N7jB6OSyGbOvDEPuG=
Hm5
LbbvrI1CCYnZD38xxDGp7ackJIAckMVF7yBY2flCLDp46cWQ0nOtuTrwgPmH8gpqY9RDSCMvK=
70+
51wY+UvPyRz+LrO2duZu1BTsSb5aobUuwd7r+pAIR+Fa2oUTMpy07pdepSBYtL8U27pwiZxxY=
eJu
6zjJ7Txtj4Ot7VIUIJxAjhaMQXWxH9BgXcSwm7+WW8JRHouJ53VRrB7qbVlp0vt9GyRzuV3ht=
ZEL
ImcYwTqCaBGsIhvNlO7g1HneEoSrYWzptHxkiUPKMTvf6so9ptWiOn0+nmeuN2W0tYFh8Lh81=
4re
/8jDPIfHg1al9rHlUD6Ki62N0lm8Ap7KK3lGx9rWhwgk+nNbcLE2yXTyZB/LuEmAqu4mDdUQZ=
xAa
fv52WaFg+31e6x60K7EpmtQycpmn78FB6QIXygxlYfheEu7BBR4iawBBbOOLGFnf8ox268Ar/=
NuR
wfemOxGDenw0SojLuOSgXK8Mtw96CeTxB1Q2M87BTQRfTsAsARAAsO4EiSE9WcN+588YGeuR/=
cX3
nWROsBeki/qPhy92oYqYx7kDP1lCqqcQI61H+qqYjE4SeVu7vkdfeLsj3UCxDqKsCJtvC0QXH=
L7b
x/IrvXYz4LWX190sYN1iZ7xoqWe2IQR91PtI06uSRr715mb9jtIbFfynKoW7R/dbXoKs3UlH6=
QwU
lTHAtd+34+KpZ0CFeyLR6n8vTFOicdqBJQ1knAu5L7S020A7WiTMES2zRg+jdyBfmLQc/lLc2=
CZb
Ktp+XaRTCR74InmtQPuSnlQJWYTkHljyd+3bbmyRHlFXLsaPHyAogLU25MUyIT2BxreTng2Fn=
JTh
SjiMexr6M9sVuFkDxC2/g9UKmgpE3a8qsnpcWtQM+f9ZWweYti//Oi/Kq6O6m9+OYTpPqAWxl=
qPz
X0beIsL/6L5yMLAE7aJX+ygmY67IaP1QaXKF2iROi/pWjmHJVViYBX5ADgw4v+8pS0A5n6SoG=
5aX
CfnN124PkGeNbip6iUKEWK+szNFMZii9r7FpT7neTgEqa4+qZBFmIfYAl1cNJcHsK9cNFIkUo=
xqx
XPbnMk8ETWGEUwJ9mNeX3X9zDcLJkamgILutSyCWzUr44bf6RUXKkZwjBt4cky70QaGPANcXd=
aDu
KZ6N/OT2Ac3MVzDbVYbxk2aAtbfvS6QnYkklaVvRm6LusjKeydsAEQEAAcLBfAQYAQgAJhYhB=
P1q
WckWdIJmBrapvy1xONLDNlK1BQJfTsAsAhsMBQkDwxP0AAoJEC1xONLDNlK1UVQP/3TZcn5cA=
9w9
FiwWr7fhOx6wikWoUE3JkAiggLIqHZkY0dhtrkeePsAAdG5371K1lHq7uLN3OW8kFGu2N9ryG=
3YH
4y4+C5QCR25YYpM6IfFUpQ1sQl2WL+SurHyQ4W9V80KHbNJxj+uM4nwgj1Wvtu2JYQ2ONSNS6=
Dpv
iFXJV3dhVIJ6r3RJ9Qo/249TBD3s2gVZgFNWozT11HyOQqMOE+Y5GxTEL1GPeDlx9NEDu1j2s=
6Nx
GI/9ho6Zs0vsX+IbtI/LacQO0HGSC3n9mf2VLLEAMhcqOsolSOPLvhKfPUlwbbQZ6cJ45c3bm=
Eg9
gw6g1ElZtnoS5VnWLbg6KXU0vMKs/524C5h8IwqcL6xPX+Colmr6vfDtUvA4zj5C/ttE1BNTu=
RvE
YSg56PrrX8KFRJnKGKG9HszkUW7jpU6bzzO7GZ0eihoothyyOG2U/jIrGMF3c1ex55mWx20AP=
a/Q
xJC2qHJrIMIhV/rTiQve+BfdlQQUwweY6lzwWHEqARbvEJHpPkxL4UxeJEa4MlBRDboF/jp8p=
n3+
CzSU83tSqQNIl2mc1wjwTrm+TkahEJaz3HRokgg28AxCtkq6usr7NiKYKJgLXq2m2leRobwM3=
CxP
F/tvwHguEhefciKKnChVjHsXYz7WP+fJBrzPaZDBiqCSHkl4YrDjw4L03CXWdun+
=3DBsuf
-----END PGP PUBLIC KEY BLOCK-----

--------------2C51C2A1FB877500362B5862--

--yYov2EcsoVMwXyuBRVWEhnJTZRwX0D1s3--

--TF26Msmu6Xpl2heDhCvBZww6WJRmlj0d8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE/WpZyRZ0gmYGtqm/LXE40sM2UrUFAl+IIFsFAwAAAAAACgkQLXE40sM2UrVJ
wBAAlMQtfcNewcOo3/P+UybWFtRHJ7JxNfmjDrpbIRILy4evIcIWXhJxkOjdK7r7VJnlbpBPIVD5
OXq6c/08oejjT34Rl592g+V+fwK/cF5vnUUY6jMkLxIStB37OXC/Qaiamzipv/bg3k40ywwHHwOk
zy9fO9UrByjVEYT9H2qRBuuLNsneiCxfl0QUpO2DzAWeitFHK1RGoFEm8DKt/XBjGbNNMX58Sr2m
gyy2EL7b8mOJPn1lUrUe6JBbS3bv244JdNw59smhhXsZ1/rrS9gVXtgc6yPJCfFS6wXxVV+WleSn
3toErd4VMNLfNpeN86YuTg1eiPKNPoPghk0Ly5jfLeNIAg9g9MR59KRgtXDCuTi/DD6Bvi04GfXg
RpVXjs9bPo4pGSmwFIaPe305SkRTMX39VRoddDnBYyrU4Sv8Cg7IX2vDhkXN0Z8sWMr/AbbU6AbE
5DFkDvKKA6WO7knoysNEfTD2GEzoBxNgvL11q3m40Ci9xkAog2n9kdXFLyUlrTDEliiht+Dowgs5
SIjCQD3s62Lvb500wWgCoAXZtjEjcOgUl82q9SZ2i6j9G00NCcg4Iv5KB4iaFvo7JYl+nxn1FxyI
vTzTJFDXnPckoMLSpS4jMzzZHSCbw2TnAgAKqNX5x5Z5KkCKN19pSo111i3RGwp8Cxg1AJxxzfb1
06Q=
=QGm+
-----END PGP SIGNATURE-----

--TF26Msmu6Xpl2heDhCvBZww6WJRmlj0d8--
