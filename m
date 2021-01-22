Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C150E3007F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbhAVP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:56:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2402 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbhAVPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:50:06 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMk9903nTz67dPN;
        Fri, 22 Jan 2021 23:45:01 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 16:49:14 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 15:49:14 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.006; Fri, 22 Jan 2021 15:49:14 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Vivek Kumar Gautam <vivek.gautam@arm.com>,
        Auger Eric <eric.auger@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
Thread-Topic: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
Thread-Index: AQHW6zfxEefN3Ne1J0G0+aXYaMMsw6ourXAAgAOzd4CAAXQVUA==
Date:   Fri, 22 Jan 2021 15:49:13 +0000
Message-ID: <5b0c640a9a22411c840367785c9c23ac@huawei.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <a8fd0176-3888-44cf-d659-2e2213a59969@redhat.com>
 <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
In-Reply-To: <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.91.124]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml2ZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVml2ZWsg
S3VtYXIgR2F1dGFtIFttYWlsdG86dml2ZWsuZ2F1dGFtQGFybS5jb21dDQo+IFNlbnQ6IDIxIEph
bnVhcnkgMjAyMSAxNzozNA0KPiBUbzogQXVnZXIgRXJpYyA8ZXJpYy5hdWdlckByZWRoYXQuY29t
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gdmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gQ2M6IGpvcm9AOGJ5dGVz
Lm9yZzsgd2lsbC5kZWFjb25AYXJtLmNvbTsgbXN0QHJlZGhhdC5jb207DQo+IHJvYmluLm11cnBo
eUBhcm0uY29tOyBqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc7DQo+IGFsZXgud2lsbGlhbXNvbkBy
ZWRoYXQuY29tOyBrZXZpbi50aWFuQGludGVsLmNvbTsNCj4gamFjb2IuanVuLnBhbkBsaW51eC5p
bnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsN
Cj4gU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBo
dWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyB2MSAwMC8xNV0gaW9tbXUvdmly
dGlvOiBOZXN0ZWQgc3RhZ2Ugc3VwcG9ydCB3aXRoDQo+IEFybQ0KPiANCj4gSGkgRXJpYywNCj4g
DQo+IA0KPiBPbiAxLzE5LzIxIDI6MzMgUE0sIEF1Z2VyIEVyaWMgd3JvdGU6DQo+ID4gSGkgVml2
ZWssDQo+ID4NCj4gPiBPbiAxLzE1LzIxIDE6MTMgUE0sIFZpdmVrIEdhdXRhbSB3cm90ZToNCj4g
Pj4gVGhpcyBwYXRjaC1zZXJpZXMgYWltcyBhdCBlbmFibGluZyBOZXN0ZWQgc3RhZ2UgdHJhbnNs
YXRpb24gaW4gZ3Vlc3RzDQo+ID4+IHVzaW5nIHZpcnRpby1pb21tdSBhcyB0aGUgcGFyYXZpcnR1
YWxpemVkIGlvbW11LiBUaGUgYmFja2VuZCBpcw0KPiA+PiBzdXBwb3J0ZWQgd2l0aCBBcm0gU01N
VS12MyB0aGF0IHByb3ZpZGVzIG5lc3RlZCBzdGFnZS0xIGFuZCBzdGFnZS0yDQo+IHRyYW5zbGF0
aW9uLg0KPiA+Pg0KPiA+PiBUaGlzIHNlcmllcyBkZXJpdmVzIGl0cyBwdXJwb3NlIGZyb20gdmFy
aW91cyBlZmZvcnRzIGhhcHBlbmluZyB0byBhZGQNCj4gPj4gc3VwcG9ydCBmb3IgU2hhcmVkIFZp
cnR1YWwgQWRkcmVzc2luZyAoU1ZBKSBpbiBob3N0IGFuZCBndWVzdC4gT24NCj4gPj4gQXJtLCBt
b3N0IG9mIHRoZSBzdXBwb3J0IGZvciBTVkEgaGFzIGFscmVhZHkgbGFuZGVkLiBUaGUgc3VwcG9y
dCBmb3INCj4gPj4gbmVzdGVkIHN0YWdlIHRyYW5zbGF0aW9uIGFuZCBmYXVsdCByZXBvcnRpbmcg
dG8gZ3Vlc3QgaGFzIGJlZW4gcHJvcG9zZWQgWzFdLg0KPiA+PiBUaGUgcmVsYXRlZCBjaGFuZ2Vz
IHJlcXVpcmVkIGluIFZGSU8gWzJdIGZyYW1ld29yayBoYXZlIGFsc28gYmVlbiBwdXQNCj4gPj4g
Zm9yd2FyZC4NCj4gPj4NCj4gPj4gVGhpcyBzZXJpZXMgcHJvcG9zZXMgY2hhbmdlcyBpbiB2aXJ0
aW8taW9tbXUgdG8gcHJvZ3JhbSBQQVNJRCB0YWJsZXMNCj4gPj4gYW5kIHJlbGF0ZWQgc3RhZ2Ut
MSBwYWdlIHRhYmxlcy4gQSBzaW1wbGUgaW9tbXUtcGFzaWQtdGFibGUgbGlicmFyeQ0KPiA+PiBp
cyBhZGRlZCBmb3IgdGhpcyBwdXJwb3NlIHRoYXQgaW50ZXJhY3RzIHdpdGggdmVuZG9yIGRyaXZl
cnMgdG8NCj4gPj4gYWxsb2NhdGUgYW5kIHBvcHVsYXRlIFBBU0lEIHRhYmxlcy4NCj4gPj4gSW4g
QXJtIFNNTVV2MyB3ZSBwcm9wb3NlIHRvIHB1bGwgdGhlIENvbnRleHQgRGVzY3JpcHRvciAoQ0Qp
DQo+ID4+IG1hbmFnZW1lbnQgY29kZSBvdXQgb2YgdGhlIGFybS1zbW11LXYzIGRyaXZlciBhbmQg
YWRkIHRoYXQgYXMgYSBnbHVlDQo+ID4+IHZlbmRvciBsYXllciB0byBzdXBwb3J0IGFsbG9jYXRp
bmcgQ0QgdGFibGVzLCBhbmQgcG9wdWxhdGluZyB0aGVtIHdpdGggcmlnaHQNCj4gdmFsdWVzLg0K
PiA+PiBUaGVzZSBDRCB0YWJsZXMgYXJlIGVzc2VudGlhbGx5IHRoZSBQQVNJRCB0YWJsZXMgYW5k
IGNvbnRhaW4gc3RhZ2UtMQ0KPiA+PiBwYWdlIHRhYmxlIGNvbmZpZ3VyYXRpb25zIHRvby4NCj4g
Pj4gQSByZXF1ZXN0IHRvIHNldHVwIHRoZXNlIENEIHRhYmxlcyBjb21lIGZyb20gdmlydGlvLWlv
bW11IGRyaXZlcg0KPiA+PiB1c2luZyB0aGUgaW9tbXUtcGFzaWQtdGFibGUgbGlicmFyeSB3aGVu
IHJ1bm5pbmcgb24gQXJtLiBUaGUNCj4gPj4gdmlydGlvLWlvbW11IHRoZW4gcGFzcyB0aGVzZSBQ
QVNJRCB0YWJsZXMgdG8gdGhlIGhvc3QgdXNpbmcgdGhlIHJpZ2h0DQo+ID4+IHZpcnRpbyBiYWNr
ZW5kIGFuZCBzdXBwb3J0IGluIFZNTS4NCj4gPj4NCj4gPj4gRm9yIHRlc3Rpbmcgd2UgaGF2ZSBh
ZGRlZCBuZWNlc3Nhcnkgc3VwcG9ydCBpbiBrdm10b29sLiBUaGUgY2hhbmdlcw0KPiA+PiBpbiBr
dm10b29sIGFyZSBiYXNlZCBvbiB2aXJ0aW8taW9tbXUgZGV2ZWxvcG1lbnQgYnJhbmNoIGJ5DQo+
ID4+IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciBbM10uDQo+ID4+DQo+ID4+IFRoZSB0ZXN0ZWQga2Vy
bmVsIGJyYW5jaCBjb250YWlucyBmb2xsb3dpbmcgaW4gdGhlIG9yZGVyIGJvdHRvbSB0bw0KPiA+
PiB0b3Agb24gdGhlIGdpdCBoYXNoIC0NCj4gPj4gYSkgdjUuMTEtcmMzDQo+ID4+IGIpIGFybS1z
bW11LXYzIFsxXSBhbmQgdmZpbyBbMl0gY2hhbmdlcyBmcm9tIEVyaWMgdG8gYWRkIG5lc3RlZCBw
YWdlDQo+ID4+ICAgICB0YWJsZSBzdXBwb3J0IGZvciBBcm0uDQo+ID4+IGMpIFNtbXUgdGVzdCBl
bmdpbmUgcGF0Y2hlcyBmcm9tIEplYW4tUGhpbGlwcGUncyBicmFuY2ggWzRdDQo+ID4+IGQpIFRo
aXMgc2VyaWVzDQo+ID4+IGUpIERvbWFpbiBuZXN0aW5nIGluZm8gcGF0Y2hlcyBbNV1bNl1bN10u
DQo+ID4+IGYpIENoYW5nZXMgdG8gYWRkIGFybS1zbW11LXYzIHNwZWNpZmljIG5lc3RpbmcgaW5m
byAodG8gYmUgc2VudCB0bw0KPiA+PiAgICAgdGhlIGxpc3QpLg0KPiA+Pg0KPiA+PiBUaGlzIGtl
cm5lbCBpcyB0ZXN0ZWQgb24gTmVvdmVyc2UgcmVmZXJlbmNlIHNvZnR3YXJlIHN0YWNrIHdpdGgg
Rml4ZWQNCj4gPj4gdmlydHVhbCBwbGF0Zm9ybS4gUHVibGljIHZlcnNpb24gb2YgdGhlIHNvZnR3
YXJlIHN0YWNrIGFuZCBGVlAgaXMNCj4gPj4gYXZhaWxhYmxlIGhlcmVbOF1bOV0uDQo+ID4+DQo+
ID4+IEEgYmlnIHRoYW5rcyB0byBKZWFuLVBoaWxpcHBlIGZvciBoaXMgY29udHJpYnV0aW9ucyB0
b3dhcmRzIHRoaXMgd29yaw0KPiA+PiBhbmQgZm9yIGhpcyB2YWx1YWJsZSBndWlkYW5jZS4NCj4g
Pj4NCj4gPj4gWzFdDQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIw
MjAxMTE4MTEyMTUxLjI1NDEyLTEtZXJpYy5hdWdlcg0KPiA+PiBAcmVkaGF0LmNvbS9ULyBbMl0N
Cj4gPj4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtYXJtLzIwMjAxMTE2MTEwMDMwLjMy
MzM1LTEyLWVyaWMuYXVnZXJAcmVkDQo+ID4+IGhhdC5jb20vVC8gWzNdDQo+ID4+IGh0dHBzOi8v
anBicnVja2VyLm5ldC9naXQva3ZtdG9vbC9sb2cvP2g9dmlydGlvLWlvbW11L2RldmVsDQo+ID4+
IFs0XSBodHRwczovL2pwYnJ1Y2tlci5uZXQvZ2l0L2xpbnV4L2xvZy8/aD1zdmEvc21tdXRlDQo+
ID4+IFs1XQ0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMTU5OTczNDczMy02NDMx
LTItZ2l0LXNlbmQtZW1haWwteWkubC5saXUNCj4gPj4gQGludGVsLmNvbS8gWzZdDQo+ID4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8xNTk5NzM0NzMzLTY0MzEtMy1naXQtc2VuZC1lbWFp
bC15aS5sLmxpdQ0KPiA+PiBAaW50ZWwuY29tLyBbN10NCj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcva3ZtLzE1OTk3MzQ3MzMtNjQzMS00LWdpdC1zZW5kLWVtYWlsLXlpLmwubGl1DQo+ID4+
IEBpbnRlbC5jb20vIFs4XQ0KPiA+PiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL3Rvb2xzLWFu
ZC1zb2Z0d2FyZS9vcGVuLXNvdXJjZS1zb2Z0d2FyZS9hcm0NCj4gPj4gLXBsYXRmb3Jtcy1zb2Z0
d2FyZS9hcm0tZWNvc3lzdGVtLWZ2cHMNCj4gPj4gWzldDQo+ID4+IGh0dHBzOi8vZ2l0LmxpbmFy
by5vcmcvbGFuZGluZy10ZWFtcy93b3JraW5nL2FybS9hcm0tcmVmZXJlbmNlLXBsYXRmbw0KPiA+
PiBybXMuZ2l0L2Fib3V0L2RvY3MvcmRuMWVkZ2UvdXNlci1ndWlkZS5yc3QNCj4gPg0KPiA+IENv
dWxkIHlvdSBzaGFyZSBhIHB1YmxpYyBicmFuY2ggd2hlcmUgd2UgY291bGQgZmluZCBhbGwgdGhl
IGtlcm5lbCBwaWVjZXMuDQo+ID4NCj4gPiBUaGFuayB5b3UgaW4gYWR2YW5jZQ0KPiANCj4gQXBv
bG9naWVzIGZvciB0aGUgZGVsYXkuIEl0IHRvb2sgYSBiaXQgb2YgdGltZSB0byBzb3J0IHRoaW5n
cyBvdXQgZm9yIGEgcHVibGljDQo+IGJyYW5jaC4NCj4gVGhlIGJyYW5jaCBpcyBhdmFpbGFibGUg
aW4gbXkgZ2l0aHViIG5vdy4gUGxlYXNlIGhhdmUgYSBsb29rLg0KPiANCj4gaHR0cHM6Ly9naXRo
dWIuY29tL3ZpdmVrLWFybS9saW51eC90cmVlLzUuMTEtcmMzLW5lc3RlZC1wZ3RibC1hcm0tc21t
dXYzLXZpDQo+IHJ0aW8taW9tbXUNCg0KVGhhbmtzIGZvciB0aGlzLiBEbyB5b3UgaGF2ZSBhIGNv
cnJlc3BvbmRpbmcga3ZtdG9vbCBicmFuY2ggbWVudGlvbmVkIGFib3ZlIGFzIHB1YmxpYz8NCg0K
VGhhbmtzLA0KU2hhbWVlcg0KDQo=
